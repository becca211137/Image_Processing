function [reconstruct, coe]= DFT(im3, option, kk)
    [n,m]=size(im3);
    c1=0;
    k=1;l=1;
    for l=0:1:m-1
        for k=0:1:n-1
            for x=0:1:n-1
                for y=0:1:m-1
                    a=x+1;b=y+1;
                    c= im3(a,b) * exp(-1i*2*pi*(k*x/n + l*y/m));
                    c1=c1+c;
                end
            end
            aa=l+1;bb=k+1;
            im(bb,aa)=c1;
            c1=0;
        end
    end
    %show
    %ims = im*255;
    %imshow(ims);
    if option == 1
        temp = zeros(n,m);
        temp(1:kk,1:kk) = im(1:kk,1:kk);
        im = temp;
    elseif option == 2
        temp = zeros(n,m);
        for i=1:kk
            m = max(im,[],'all');
            index = find(im==m,1);
            temp(index) = m;
            im(index) = 0;
        end
        im = temp;
    else
        coe = im;
    end
    coe = im;
    %im = real(im);
    [n,m]=size(im3);
    % inverse
    for l=0:1:m-1
        for k=0:1:n-1
            for x=0:1:n-1
                for y=0:1:m-1
                    a=x+1;b=y+1;
                    c= im(a,b) * exp(1i*2*pi*(k*x/n + l*y/m));
                    c1=c1+c;
                end
            end
            aa=l+1;bb=k+1;
            reconstruct(bb,aa)=c1;
            c1=0;
        end
    end
    reconstruct = reconstruct/(n*m);
    %imshow(uint8(reconstruct));
end
