load carsmall
Origin = nominal(Origin) % Origin streing halinde data sette duruyordu aracın hangi ülkeye ait oldugunu belirtlen bir özellik
% String i nominal data tipine çeviriyoruz. tırnaklar kalktı kategorik olarak işlenebilir hale geldi.

getlevels(Origin) % İçinde  kaç tane grup va rdiye görebiliyoruz: 6 tane data seti

%% Kategoriye göre gruplandırılmış  veriler
figure
boxplot(Acceleration,Origin)
title('Acceleration, Grouped by Country of Origin')

% bu analiz ile Örneğin İtalyada çok az sayıda araç oldugunu öğrenmiş
% oluyoruz.
%% Kategori sayılarını tablola.

tabulate(Origin)
%% Kategori kaldırma işlemi.
Acceleration2 = Acceleration(Origin~='Italy');
Origin2 = Origin(Origin~='Italy');
getlevels(Origin2)
Origin2 = droplevels(Origin2,'Italy');
tabulate(Origin2)
figure
boxplot(Acceleration2,Origin2)
title('Acceleration, Grouped by Country of Origin')