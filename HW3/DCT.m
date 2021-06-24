function [reconstruct, coe ]= DCT(im3, option, kk)
    [n,m]=size(im3);
    p = zeros(1,m)+sqrt(2/m);
    p(1)=1/sqrt(m);
    q = zeros(1,n)+sqrt(2/n);
    q(1)=1/sqrt(n);
    
    c1=0;
    k=1;l=1;
    for l=0:1:m-1
        for k=0:1:n-1
            for x=0:1:n-1
                for y=0:1:m-1
                    a=x+1;b=y+1;
                    c= im3(a,b) * cos((2*x+1)*pi*l / (2*m))*cos((2*y+1)*pi*k / (2*n));
                    c1=c1+c;
                end
            end
            aa=l+1;bb=k+1;
            im(bb,aa)=p(aa)*q(bb)*c1;
            c1=0;
        end
    end    
    coe = im;
    %figure(4);
    %imshow(uint8(im));
    if option == 1
        temp = zeros(n,m);
        temp(1:kk,1:kk) = im(1:kk,1:kk);
        im = temp;
    elseif  option == 2
        temp = zeros(n,m);
        for i=1:kk
            m = max(im,[],'all');
            index = find(im==m,1);
            temp(index) = m;
            im(index) = 0;
        end
        im = temp;
    else
    end
    % inverse
    [n,m]=size(im3);
    for l=0:1:m-1
        for k=0:1:n-1
            for x=0:1:n-1
                for y=0:1:m-1
                    a=x+1;b=y+1;
                    c= p(a)*q(b)*im(a,b) * cos((2*l+1)*pi*x / (2*m))*cos((2*k+1)*pi*y / (2*n));
                    c1=c1+c;
                end
            end
            aa=l+1;bb=k+1;
            reconstruct(bb,aa)=c1;
            c1=0;
        end
    end
    %figure(5);
    %imshow(uint8(reconstruct));
end
