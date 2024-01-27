clear
clc
close all

% Membaca Data Train
foldDtTrain = 'E:\KuliahUdinus\Matlab file\PCD\klasifikasi_buah\Tekstur\data latih';
imds = imageDatastore(foldDtTrain,'IncludeSubfolders',true,'FileExtensions','.jpg','LabelSource','foldernames');
for i = 1 : length(imds.Files)
    nmfile = imds.Files{i};
    % Membaca Citra
    img = imread(nmfile);
    
    % Image Processing Contrast
    contrast = 3; 
    img = contrast + img;
    
    %Fitur ekstraksi rerata
    img = double(img);
    rata2 = mean(img,'all');
    fitur(i,:) = [rata2];
end
fiturTrain = fitur; clear fitur
labelTrain = imds.Labels; clear label

% Pemodelan machine learning
% mdl = fitcknn(fiturTrain,labelTrain);       %K-NN
% mdl = fitcsvm(fiturTrain,labelTrain);       %SVM
mdl = fitcnb(fiturTrain,labelTrain);        %Naive Bayes

% Prediksi
labelPredict = predict(mdl,fiturTrain);

% Evaluasi Akurasi
akurasiTrain = (length(labelPredict)/length(labelPredict))*100



% Membaca Data Test
foldDtTest = 'E:\KuliahUdinus\Matlab file\PCD\klasifikasi_buah\Tekstur\data uji';
imds = imageDatastore(foldDtTest,'IncludeSubfolders',true,'FileExtensions','.jpg','LabelSource','foldernames');
for i = 1 : length(imds.Files)
    nmfile = imds.Files{i};
    % Membaca Citra
    img = imread(nmfile);

    % Image Processing Contrast
    contrast = 3;
    img = contrast + img;
    
    % Ekstraksi fitur rerata
    img = double(img);
    rata2 = mean(img,'all');
    fitur(i,:) = [rata2 ];
end
fiturTest = fitur; clear fitur
labelTest = imds.Labels;

% Prediksi
labelTestPredict = predict(mdl,fiturTest);

% Evaluasi Akurasi
akurasiTest = (sum(labelTest==labelTestPredict)/length(labelTestPredict))*100


