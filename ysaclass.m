%% Ama� S�n�fland�rma sorunlar�n� YSA ile nas�l ��zebiliriz.Hata matrislerinin hesaplanmas� ve do�ruluklar�n�n y�zde olarak g�r�lmesi

% Train'de ��kt� vekt�r� 1. s�tundur. geri kalan 12 s�tun input de�eridir.

%% S�n�fland�rma Tahmini
% Zaman serisinde 1 tane �zelli�i olan veri seti kullan�ld��� i�in �ok normalizasyon yap�lmad� ama burda 12 tane �zellik vard�r.
clc
clear;
close all;
%% Load Data: Veri Haz�rlama
data = load('C-DATA');
Train = data.Train;
test = data.Test;
inputtrain = Train(:,2:end);
outputtrain = Train(:,1);

inputtest = test(:,2:end);
outputtest = test(:,1);
%% Normalization: Normalizasyonun her bir s�tuna ayr� ayr� yap�lmas� gerekiyor.
inputnum = size(inputtrain,2);
XtrN=inputtrain;
XtsN=inputtest;
for ii=1:inputnum
    XtrN(:,ii) = normalization_func(inputtrain(:,ii));
    XtsN(:,ii) = normalization_func(inputtest(:,ii));
end

%% Output Coding : S�n�fland�rma i�in mutlaka yap�lmas� gerekiyor.S�n�flar� Binary kodlamaya �ekmemiz gerekiyor.YSA n�n anlayabilmesi i�in.
outputtrcoding = zeros(size(outputtrain,1),5); %�nce bo� bir matris haz�rland�. 5: s�n�f say�m�z
outputtscoding = zeros(size(outputtest,1),5);

for ii=1:size(outputtrcoding,1)
    outputtrcoding(ii,outputtrain(ii))=1;
end

for ii=1:size(outputtscoding,1)
    outputtscoding(ii,outputtest(ii))=1;
end

%% Create Network
%layers = 3;
layers = [10 5]; % 1 katta 10 n�ron say�s� 2. katta 5 n�ron say�s� olarak kullanabiliriz.
transfer_function ={'tansig','tansig'};
trainFcn = 'trainbr'; % e�itim algortimas�n� ba�ka bir algoritma olarak de�i�tiriyoruz.
network = newfit(XtrN',outputtrcoding',layers,transfer_function,trainFcn); % bir a� olu�turuldu.ysa verileri s�tun olarak kullan�l�yor.O y�zden transpoz al�n�r.

trained_network = train(network,XtrN',outputtrcoding');
%% Test Network
% sinavtr = sim(trained_network,XtrN');
% MSEtr = mse(sinavtr - outputtrcoding')
sinavtr = sim(trained_network,XtrN')';
MSEtr = mse(sinavtr - outputtrcoding);
ysasiniftr=sinifbelirleme(sinavtr);

% sinavts = sim(trained_network,XtsN');
% MSEts = mse(sinavts - outputtscoding')
sinavts = sim(trained_network,XtsN')';
MSEts = mse(sinavts - outputtscoding)
ysasinifts=sinifbelirleme(sinavts);
%Not: sinavts ve sinavtr de�erlerini daha anla��l�r ifade etmek amac�yla 'sinifbelirleme fonksiyonu' yaz�lm��t�r.

%% Grafikler
%Confusion Matrix: Performans�n� de�erlendirmek i�in tahminlerin ve ger�ek de�erlerin kar��la�t�r�ld��� hata matrisi s�kl�kla kullan�lmaktad�r.

hatamatrisiTR=confusionmat(outputtrain,ysasiniftr)
hatamatrisiTS=confusionmat(outputtest,ysasinifts)

CCRTR = sum(diag(hatamatrisiTR))/sum(sum(hatamatrisiTR))*100

CCRTS = sum(diag(hatamatrisiTS))/sum(sum(hatamatrisiTS))*100