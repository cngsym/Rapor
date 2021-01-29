%% Amaç Sýnýflandýrma sorunlarýný YSA ile nasýl çözebiliriz.Hata matrislerinin hesaplanmasý ve doðruluklarýnýn yüzde olarak görülmesi

% Train'de çýktý vektörü 1. sütundur. geri kalan 12 sütun input deðeridir.

%% Sýnýflandýrma Tahmini
% Zaman serisinde 1 tane özelliði olan veri seti kullanýldýðý için çok normalizasyon yapýlmadý ama burda 12 tane özellik vardýr.
clc
clear;
close all;
%% Load Data: Veri Hazýrlama
data = load('C-DATA');
Train = data.Train;
test = data.Test;
inputtrain = Train(:,2:end);
outputtrain = Train(:,1);

inputtest = test(:,2:end);
outputtest = test(:,1);
%% Normalization: Normalizasyonun her bir sütuna ayrý ayrý yapýlmasý gerekiyor.
inputnum = size(inputtrain,2);
XtrN=inputtrain;
XtsN=inputtest;
for ii=1:inputnum
    XtrN(:,ii) = normalization_func(inputtrain(:,ii));
    XtsN(:,ii) = normalization_func(inputtest(:,ii));
end

%% Output Coding : Sýnýflandýrma için mutlaka yapýlmasý gerekiyor.Sýnýflarý Binary kodlamaya çekmemiz gerekiyor.YSA nýn anlayabilmesi için.
outputtrcoding = zeros(size(outputtrain,1),5); %Önce boþ bir matris hazýrlandý. 5: sýnýf sayýmýz
outputtscoding = zeros(size(outputtest,1),5);

for ii=1:size(outputtrcoding,1)
    outputtrcoding(ii,outputtrain(ii))=1;
end

for ii=1:size(outputtscoding,1)
    outputtscoding(ii,outputtest(ii))=1;
end

%% Create Network
%layers = 3;
layers = [10 5]; % 1 katta 10 nöron sayýsý 2. katta 5 nöron sayýsý olarak kullanabiliriz.
transfer_function ={'tansig','tansig'};
trainFcn = 'trainbr'; % eðitim algortimasýný baþka bir algoritma olarak deðiþtiriyoruz.
network = newfit(XtrN',outputtrcoding',layers,transfer_function,trainFcn); % bir að oluþturuldu.ysa verileri sütun olarak kullanýlýyor.O yüzden transpoz alýnýr.

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
%Not: sinavts ve sinavtr deðerlerini daha anlaþýlýr ifade etmek amacýyla 'sinifbelirleme fonksiyonu' yazýlmýþtýr.

%% Grafikler
%Confusion Matrix: Performansýný deðerlendirmek için tahminlerin ve gerçek deðerlerin karþýlaþtýrýldýðý hata matrisi sýklýkla kullanýlmaktadýr.

hatamatrisiTR=confusionmat(outputtrain,ysasiniftr)
hatamatrisiTS=confusionmat(outputtest,ysasinifts)

CCRTR = sum(diag(hatamatrisiTR))/sum(sum(hatamatrisiTR))*100

CCRTS = sum(diag(hatamatrisiTS))/sum(sum(hatamatrisiTS))*100