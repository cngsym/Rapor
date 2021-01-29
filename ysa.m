%% YSA da zaman Serisi Tahmini
clc
clear;
close all;
%% Load Data
data = load('mgdata.dat'); % Kullanýlan bir zaman serisi verisidir.
d = data(:,2);
%plot(d)
%% Normalization
% Duraðan haldedir dolayýsýyla logaritmasýný ve diferansiyalini almamýza gerek yoktur.Duraðan olmasaydý duraðan hale getirecektik.
%% Veri Seti Hazýrlama: input ve targeti birbÝrinden ayýrmak
target = d(53:end);
x52=d(1:end-52);
x26=d(27:end-26);
x17=d(36:end-17);
x1= d(52:end-1);
input = [x52,x26,x17,x1];
data = [input,target];
satir = size (data,1);
%% YSA Yeni tahmin yapmadan önce var olan bilgilerden bir kýsmýný test amaçlý kullanýyoruz.
traindata = data(1:satir-149,:);
traininputs = (traindata(:,1:end-1))';
traintarget =  (traindata(:,end))';

testdata = data(end-148:end,:);
testinputs = (testdata(:,1:end-1))';
testtarget =  (testdata(:,end))';
%% Create Network
%layers = 3;
layers = [10 5]; % 1 katta 10 nöron sayýsý 2. katta 5 nöron sayýsý olarak kullanabiliriz.
transfer_function ={'tansig','purelin'};
trainFcn = 'trainbr'; % eðitim algortimasýný baþka bir algoritma olarak deðiþtiriyoruz.
network = newfit(traininputs,traintarget,layers,transfer_function,trainFcn); % bir að oluþturuldu.ysa verileri sütun olarak kullanýlýyor.

trained_network = train(network,traininputs,traintarget);
%% test network
sinavts = sim(trained_network,testinputs); % 149 tane eðitime almadýðýmýz verilerden að dan eðitim almýþ bir network un sonucu test datalarý için atýlan deðiþken
hatats = (sinavts - testtarget);% gerçek cevapla ile karþýlatýrýlmasýnýn sonucunda karþýlaþýlan hata.
%% ysa 'nýn gördüðü  verilerden test edilmesi
sinavtr = sim(trained_network,traininputs);
hatatr = (sinavtr - traintarget)
%% Grafiksel gösterimler:
figure;
subplot(2,2,[1 2])
plot(traintarget,'b')
hold on
plot(sinavtr,'r')
legend('gerçek','ysa dan gelen sonuç') % gerçek veriler ve ysa dan geeln sonuçlarýn ortak grafiði

subplot(2,2,3)
plot(hatatr);
legend('hatalar')
subplot(2,2,4)
histfit(hatatr);
legend('hatalar')
%% Grafiksek gösteri: test datalarý için
figure;
subplot(2,2,[1 2])
plot(testtarget,'b')
hold on
plot(sinavts,'r')
legend('gerçek','ysa dan gelen sonuç') % gerçek veriler ve ysa dan geeln sonuçlarýn ortak grafiði

subplot(2,2,3)
plot(hatats);
legend('hatalar')
subplot(2,2,4)
histfit(hatats);
legend('hatalar')


