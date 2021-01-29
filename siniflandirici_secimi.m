%% Otomatik olarak sınıflandırıcı seçimi
load humanactivity
rng('default')
c = cvpartition(actid,'Holdout',0.10); % verimizi 2 ye bölebiliyoruz. %10 test %90 trainging için
trainingIndices = traing(c);
XTrain = feat(trainingIndices,:);
YTrain = actid(trainingIndices);
testIndices = test(c);
XTest = feat(testIndices,:);
YTest = actid(testIndices)
%% Run fit classification auto
[MdI,OptimizationResults] = fitcauto(XTrain,YTrain);

%% test seti performansını değerlendirmek
testAccuracy =  1 - loss(MdI,XTest,YTest); % ne kadar doğru sınıflandırma yaptıgını ölçüyoruz.


