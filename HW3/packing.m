function en = packing(coe, trans)
    if trans == 'WHT'
        coe =  coe*255;
    elseif trans == 'DFT'
        coe = real(coe);
    else
        coe =  coe*255;        
    end
    [n,m] = size(coe);
    coe(coe<0)=0;
    coe(coe>255)=255;
    % range=1-256
    coe = round(coe)+1;
    inf = zeros(1,256);
    for i=1:n
        for j=1:m            
            inf(coe(i,j)) = inf(coe(i,j)) + 1;
        end
    end
    inf = inf./(n*m);
    en = 0;
    for i=1:256
        if inf(i)~=0
            en = en - inf(i) *  log2(inf(i));
        end
    end
end