function sinif=sinifbelirleme(Netout)
sinif=zeros(size(Netout,1),1);
for ii=1:numel(sinif)
    NO = Netout(ii,:)
    I=find(NO==max(NO));
    sinif(ii)=I;    
end
%YSA'nın bulundugu tahmini anlayabildiğimiz forma çekiyoruz.