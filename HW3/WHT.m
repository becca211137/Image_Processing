function [reconstruct, inverse]=WHT(gray, option, k)
% 0 - no change  ;1 - keep k*k ; 2 - k largest
    [n,m]=size(gray);
    H = make_hadamard(n);
    inverse = H*gray*H / (n*n);
    if option == 1
        temp = zeros(n,m);
        temp(1:k,1:k) = inverse(1:k,1:k);
        inverse = temp;
    elseif  option == 2
        temp = zeros(n,m);
        for i=1:k
            m = max(inverse,[],'all');
            index = find(inverse==m,1);
            temp(index) = m;
            inverse(index) = 0;
        end
        inverse = temp;
    else
    end
%     figure(2);
%     imshow(im2uint8(inverse));
    reconstruct=H'*inverse*H';
%     figure(3);
%     imshow(uint8(reconstruct));
end