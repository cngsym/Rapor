function sinif=sinifbelirleme(Netout)
sinif=zeros(size(Netout,1),1);
for ii=1:numel(sinif)
    NO = Netout(ii,:)
    I=find(NO==max(NO));
    sinif(ii)=I;    
end
%YSA'nýn bulundugu tahmini anlayabildiðimiz forma çekiyoruz.