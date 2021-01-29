%% Trend eden bir seriyi durağan hale dönüştürmek
% artık input selecetionu da daha rahat 
clc
clear;
close all;
load data_gdp
y=Data;
subplot(2,2,1);
plot(y)

dy=diff(y);
subplot(2,2,2);
plot(dy)

ly=log(y);
subplot(2,2,3);
plot(ly)

dfi = diff(ly);
subplot(2,2,4);
plot(dfi)