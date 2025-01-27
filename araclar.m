%% dağılım grafiği matrisleri
% Her bir değişkenin diğer değişkenlere göre dağılımını görmemize yarar.
load carbig
X = [MPG,Acceleration,Displacement,Weight,Horsepower];
varNames ={'MPG','Acceleration','Displacement','Weight','Horsepower'};
figure
gplotmatrix(X,[],Cylinders,['c','b','m','g','r'],[],[],false);
text([.08 .24 .43 .66 .83], repmat(-.1,1,5),varNames,'FontSize',8);
text(repmat(-.12,1,5),[.86 .62 .41 .25 .02],varNames,'FontSize',8,'Rotation',90);
%% Paralel Koordinatlar Plotu:silindir değeri 4 e eşit olanlar mavi, 6 ya eşit olanlar kırmızı, 8 e eşit olanlar sarı olacak şekilde gruplandırılmıştır.
Cyl468 = ismember(Cylinders,[4 6 8]);
parallelcoords(X(Cyl468,:),'group',Cylinders(Cyl468),'standardize','on','labels',varNames)
parallelcoords(X(Cyl468,:),'group',Cylinders(Cyl468),'standardize','on','labels',varNames,'quantile',.25) % her bir gurubun mean değerlerinden geçen plotu çizer.


%% Andrews plots: paralel koordinatlardan farkı daha smoot çizgilerler ayrılmasıdır.
andrewsplot(X(Cyl468,:),'group',Cylinders(Cyl468),'standardize','on')

%%
h = glyphplot(X(1:9,:),'glyph','star','obslabels',Model(1:9,:));
