function Xn = normalization_func(x)
xmin = min(x);
xmax = max(x);
Xn = (x-xmin)/(xmax-xmin)*2-1;
end
%De�erleri 0 ile 1 aras�na normalizasyon yaparak da��tt�.
