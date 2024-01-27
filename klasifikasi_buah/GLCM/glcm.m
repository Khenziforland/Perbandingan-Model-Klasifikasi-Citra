function [fitur_mat,kelas] = glcm(datasetku)
    jmlkls=length(datasetku);       % Panjang Data Latih/Train
    
    % Mengambil berapa banyak jumlah data di folder Data Latih/Train
    for n=1:jmlkls
        cd(char(datasetku(n)));                 % Mengakses Directory datasetku
        datacitra=dir('*.jpg');                 % Membaca Seluruh Citra
        jmldata=length(datacitra);  
        for i=1:jmldata
           namafile=datacitra(i).name;          % Mengambil nama gambar
           citrai=rgb2gray(imread(namafile));   % Gambar diconvert ke Grayscale
           
           % Proses GLCM
           fitur = graycoprops(graycomatrix(citrai));
           % graycomatrix => Membuat Matrix GLCM
           % graycoprops => Mengambil 4 buah fitur
           
           fitur_mat(i+jmldata*(n-1),1)=fitur.Contrast;
           fitur_mat(i+jmldata*(n-1),2)=fitur.Correlation;
           fitur_mat(i+jmldata*(n-1),3)=fitur.Energy;
%            fitur_mat(i+jmldata*(n-1),4)=fitur.Homogeneity;

           % Membuat kelas untuk menentukan termasuk kelas yang mana
           kelas(i+jmldata*(n-1))=n;
        end
        cd('..');
    end
end

