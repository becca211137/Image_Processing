function ans = snr(ori, re)
    [n,m] = size(ori);    
    ans = sum(re.^2, 'all') / sum((ori-re).^2,'all');
end