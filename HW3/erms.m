function ans = erms(ori, re)
    [n,m] = size(ori);
    ans = sqrt( sum((ori-re).^2,'all') / (n*m) );
    
end