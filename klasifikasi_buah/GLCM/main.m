clear
clc
close all

% Data Latih/Train
cd('E:\KuliahUdinus\Matlab file\PCD\klasifikasi_buah\GLCM');     %Mengakses Directory File
datasetku = {'B1';'B2'};

% Fungsi GLCM
[fitur_mat, kelas]=glcm(datasetku);


% Model klasifikasi K-NN
model=fitcknn(fitur_mat,kelas');

% Model klasifikasi SVM
% model=fitcsvm(fitur_mat,kelas');

% Model klasifikasi Naive Bayes
% model=fitcnb(fitur_mat,kelas');





% Pengujian akurasi menggunakan Data Uji
[uji,target,klasifikasi,hasil] = tes_grup(model);
[{'Contrast','Correlation','Energy','Target','Kelas','Hasil'};
    num2cell([uji target' klasifikasi']) hasil']

% Confusion Matrix
cm = confusionmat(target',klasifikasi')
akurasiTrain = (sum(sum(cm))/sum(sum(cm)))*100
akurasiTest = (sum(diag(cm))/sum(sum(cm)))*100

