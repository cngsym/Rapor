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
% algoritmamýmýza  tek sütundan oluþan d matrisini veremeyiz o yüzden 
% inputlarýmýzý hazýrladýk.
%%
%diyelimki bizim senaryomuzda input selection geriye dönük geçen haftanýn
%veya 52 gün önceye bakarak denemek istiyorsak
%52. gün diyosa bizim targetimiz 53 den baþlayabilr.
% 1. gün ,17 gün,26 gün ve 52 gün önce ki verileri kullanrak inputlarý
% kullandýk.
target52 = d(53:end);
x52=d(1:end-52);
x26=d(27:end-26);
x17=d(36:end-17);
x1_yeni= d(52:end-1);
input2 = [x52,x26,x17,x1_yeni];
r = [input2,target52];

