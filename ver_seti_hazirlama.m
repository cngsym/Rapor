clc
clear;
close all;
d = load('data_gdp');
d = d.Data;
target = d(5:end);
x4=d(1:end-4);
x3=d(2:end-3);
x2=d(3:end-2);
x1=d(4:end-1);
input = [x4,x3,x2,x1];
% algoritmam�m�za  tek s�tundan olu�an d matrisini veremeyiz o y�zden 
% inputlar�m�z� haz�rlad�k.
%%
%diyelimki bizim senaryomuzda input selection geriye d�n�k ge�en haftan�n
%veya 52 g�n �nceye bakarak denemek istiyorsak
%52. g�n diyosa bizim targetimiz 53 den ba�layabilr.
% 1. g�n ,17 g�n,26 g�n ve 52 g�n �nce ki verileri kullanrak inputlar�
% kulland�k.
target52 = d(53:end);
x52=d(1:end-52);
x26=d(27:end-26);
x17=d(36:end-17);
x1_yeni= d(52:end-1);
input2 = [x52,x26,x17,x1_yeni];
r = [input2,target52];

