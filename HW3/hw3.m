function hw3(file)
    ori_pic=imread('cat2.jpeg');
%     figure(1);
%     imshow(ori_pic);
    r = double(ori_pic(:,:,1));
    g = double(ori_pic(:,:,2));
    b = double(ori_pic(:,:,3));
    gray = double(0.2989*r + 0.5870*g + 0.1140*b);
    block_size = 16;
    [n,m]=size(gray);
    result = zeros(n,m);
    coe = zeros(m,n);
    for i = 1:n/block_size
        for j = 1:m/block_size
            temp = gray( (i-1)*block_size+1:(i-1)*block_size+block_size, (j-1)*block_size+1:(j-1)*block_size+block_size);
           % [reconstruct, c]=WHT(temp,0,25);
           % [reconstruct, c]=DFT(temp,2,25);
             [reconstruct, c]=DCT(temp,2,25);
            result( (i-1)*block_size+1:(i-1)*block_size+block_size, (j-1)*block_size+1:(j-1)*block_size+block_size) = reconstruct;
            coe( (i-1)*block_size+1:(i-1)*block_size+block_size, (j-1)*block_size+1:(j-1)*block_size+block_size) = c;
        end
    end    
    en=packing(coe,'DCT')
    error = erms(gray, result)
    error2 = snr(gray, result)
    % figure(2);
    % imshow(uint8(real(result)));
     imwrite(uint8(real(result)),'1.jpg','Quality',100);
end
