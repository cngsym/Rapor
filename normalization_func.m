function Xn = normalization_func(x)
xmin = min(x);
xmax = max(x);
Xn = (x-xmin)/(xmax-xmin)*2-1;
end
%Deðerleri 0 ile 1 arasýna normalizasyon yaparak daðýttý.
