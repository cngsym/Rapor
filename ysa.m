%% YSA da zaman Serisi Tahmini
clc
clear;
close all;
%% Load Data
data = load('mgdata.dat'); % Kullan�lan bir zaman serisi verisidir.
d = data(:,2);
%plot(d)
%% Normalization
% Dura�an haldedir dolay�s�yla logaritmas�n� ve diferansiyalini almam�za gerek yoktur.Dura�an olmasayd� dura�an hale getirecektik.
%% Veri Seti Haz�rlama: input ve targeti birb�rinden ay�rmak
target = d(53:end);
x52=d(1:end-52);
x26=d(27:end-26);
x17=d(36:end-17);
x1= d(52:end-1);
input = [x52,x26,x17,x1];
data = [input,target];
satir = size (data,1);
%% YSA Yeni tahmin yapmadan �nce var olan bilgilerden bir k�sm�n� test ama�l� kullan�yoruz.
traindata = data(1:satir-149,:);
traininputs = (traindata(:,1:end-1))';
traintarget =  (traindata(:,end))';

testdata = data(end-148:end,:);
testinputs = (testdata(:,1:end-1))';
testtarget =  (testdata(:,end))';
%% Create Network
%layers = 3;
layers = [10 5]; % 1 katta 10 n�ron say�s� 2. katta 5 n�ron say�s� olarak kullanabiliriz.
transfer_function ={'tansig','purelin'};
trainFcn = 'trainbr'; % e�itim algortimas�n� ba�ka bir algoritma olarak de�i�tiriyoruz.
network = newfit(traininputs,traintarget,layers,transfer_function,trainFcn); % bir a� olu�turuldu.ysa verileri s�tun olarak kullan�l�yor.

trained_network = train(network,traininputs,traintarget);
%% test network
sinavts = sim(trained_network,testinputs); % 149 tane e�itime almad���m�z verilerden a� dan e�itim alm�� bir network un sonucu test datalar� i�in at�lan de�i�ken
hatats = (sinavts - testtarget);% ger�ek cevapla ile kar��lat�r�lmas�n�n sonucunda kar��la��lan hata.
%% ysa 'n�n g�rd���  verilerden test edilmesi
sinavtr = sim(trained_network,traininputs);
hatatr = (sinavtr - traintarget)
%% Grafiksel g�sterimler:
figure;
subplot(2,2,[1 2])
plot(traintarget,'b')
hold on
plot(sinavtr,'r')
legend('ger�ek','ysa dan gelen sonu�') % ger�ek veriler ve ysa dan geeln sonu�lar�n ortak grafi�i

subplot(2,2,3)
plot(hatatr);
legend('hatalar')
subplot(2,2,4)
histfit(hatatr);
legend('hatalar')
%% Grafiksek g�steri: test datalar� i�in
figure;
subplot(2,2,[1 2])
plot(testtarget,'b')
hold on
plot(sinavts,'r')
legend('ger�ek','ysa dan gelen sonu�') % ger�ek veriler ve ysa dan geeln sonu�lar�n ortak grafi�i

subplot(2,2,3)
plot(hatats);
legend('hatalar')
subplot(2,2,4)
histfit(hatats);
legend('hatalar')


