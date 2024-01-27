clear
clc
close all

foldDtTrain = 'E:\KuliahUdinus\Matlab file\klasifikasi_buah\Tekstur\data latih';
imds = imageDatastore(foldDtTrain,'IncludeSubfolders',true,'FileExtensions','.jpg','LabelSource','foldernames');
for i = 1 : length(imds.Files)
    nmfile = imds.Files{i};
    % membaca citra
    img = imread(nmfile);

    % membuat fitur sederhana
    %img = double(img);
    %rata2 = mean(img,'all');
    %stdev = std(img,0,'all');
    %fitur(i,:) = [rata2, stdev];
    [Stat] = stattekstur(img);
    fitur(i,:) = Stat.all;
end
fiturTrain = fitur; clear fitur
labelTrain = imds.Labels; clear label

% pemodelan machine learning
% mdl = fitcknn(fiturTrain,labelTrain);       %K-NN
% mdl = fitcsvm(fiturTrain,labelTrain);       %SVM
mdl = fitcnb(fiturTrain,labelTrain);        %Naive Bayes

labelPredict = predict(mdl,fiturTrain);

akurasiTrain = length(labelPredict)/length(labelPredict)*100

% testing
foldDtTest = 'E:\KuliahUdinus\Matlab file\klasifikasi_buah\Tekstur\data uji';
imds = imageDatastore(foldDtTest,'IncludeSubfolders',true,'FileExtensions','.jpg','LabelSource','foldernames');
for i = 1 : length(imds.Files)
    nmfile = imds.Files{i};
    % membaca citra
    img = imread(nmfile);

    % membuat fitur sederhana
    %img = double(img);
    %rata2 = mean(img,'all');
    %stdev = std(img,0,'all');
    %fitur(i,:) = [rata2, stdev];
    [Stat] = stattekstur(img);
    fitur(i,:) = Stat.all;
end
fiturTest = fitur; clear fitur
labelTest = imds.Labels;
% prediksi
labelTestPredict = predict(mdl,fiturTest);
% evaluasi
akurasiTest = (sum(labelTest==labelTestPredict)/length(labelTestPredict))*100

