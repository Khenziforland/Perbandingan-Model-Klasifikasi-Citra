function [uji,target,klasifikasi,hasil] = tes_grup(model)
    % % Data Uji/Test
    cd('E:\KuliahUdinus\Matlab file\PCD\klasifikasi_buah\GLCM\data uji');
    data={'B1';'B2'};
    jmlkls=length(data);                        % Panjang Data Uji/Test
    
    % Mengambil berapa banyak jumlah data di folder Data Uji/Test
    for n=1:jmlkls
        cd(char(data(n)));
        datacitra=dir('*.jpg');
        jmldata=length(datacitra);  
        for i=1:jmldata
            namafile=datacitra(i).name;         % Mengambil nama gambar
            a=rgb2gray(imread(namafile));       % Gambar diconvert ke Grayscale
            
            m=graycomatrix(a);                  % Membuat Matrix
            g=graycoprops(m);                   
            uji(i+jmldata*(n-1),1)=g.Contrast;
            uji(i+jmldata*(n-1),2)=g.Correlation;
            uji(i+jmldata*(n-1),3)=g.Energy;
%             uji(i+jmldata*(n-1),4)=g.Homogeneity;
            
            % Melakukan prediksi dari model
            target(i+jmldata*(n-1))=n;
            klasifikasi(i+jmldata*(n-1))=model.predict(uji(i+jmldata*(n-1),:));
            if klasifikasi(i+jmldata*(n-1))==target(n)
                hasil(i+jmldata*(n-1))={'Benar'};
            else
                hasil(i+jmldata*(n-1))={'Salah'};
            end
        end
        cd('..');
    end
end

