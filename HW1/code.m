function code(file)
    for pic_index=1:6
        % 讀取圖片並顯示
        filename = strcat('p1im',num2str(pic_index), '.bmp');
        ori_pic = imread(filename);
        figure(pic_index);
        image(ori_pic);
        % 分成r,g,b三通道存起來
        r = (ori_pic(:,:,1));
        g = (ori_pic(:,:,2));
        b = (ori_pic(:,:,3));
        pic = {r,g,b};
        % 根據不同圖片用不同function處理
        switch pic_index
            case 1
                result = laplacian(pic);
            case 2
               result = gamma(pic, 1, 3.75);
            case 3
                result = log_trans(pic);
            case 4
                result = gauss(pic,ori_pic);
            case 5
                result = contrast(pic, 100);
            case 6
                result = adaptive_filter(pic, 3);
        end
    end
end

function result = laplacian(pic)
    [row, col] = size(pic{1});
    f=zeros([row,col]);
    for index=1:3
        % 將邊界補0
        pad = padarray(double(pic{index}),[1,1]);
        for i=1:size(pad,1)-2
            for j=1:size(pad,2)-2
                temp = pad(i,j+1)+pad(i+1,j)+pad(i+1,j+2)+pad(i+2,j+1)-4*pad(i+1,j+1);
                f(i,j)=temp;
            end
        end
        result(:,:,index) = uint8(double(pic{index}) - f);        
    end
    figure(7);
    imshow(result);
    imwrite(result,'p1im1_0516222.bmp');
end
% s = c*r^rate
function result = gamma(pic, c, rate)
    for i=1:3
        temp = double(pic{i});
        result(:,:,i) = temp/255;
        result(:,:,i) = c * (result(:,:,i).^rate);
        result(:,:,i) = result(:,:,i)*255;
    end
    result=uint8(result);
    figure(8);
    imshow(result);
    imwrite(result,'p1im2_0516222.bmp');
end
% s=c*log(1+r)
function result = log_trans(pic)
    c=2;
    for i=1:3
        temp = double(pic{i});
        temp = temp/255;
        result(:,:,i) = c * log(1+temp);
        result(:,:,i) = result(:,:,i)*255;
    end
    result = uint8(result);
    figure(9);
    imshow(result);
    imwrite(result,'p1im3_0516222.bmp');
end
function result = gauss(pic,ori_pic)
    for i=1:3
        A = fft2(double(pic{i}));
        A1=fftshift(A);
        [M N]=size(A);
        R=5;
        X=0:N-1;
        Y=0:M-1;
        [X Y]=meshgrid(X,Y);
        Cx=0.5*N;
        Cy=0.5*M;
        Lo=exp(-((X-Cx).^2+(Y-Cy).^2)./(2*R).^2);
        Hi=1-Lo;
        K=A1.*Hi;
        K1=ifftshift(K);
        result(:,:,i)=ifft2(K1);
    end
    result = ori_pic+uint8(abs(result));
    figure(10);
    imshow(result);
    imwrite(result,'p1im4_0516222.bmp');
end
function result = contrast(pic, c)
    f = (259 * (c + 255) ) / (255 * (259 - c));
    for i=1:3
        temp = double(pic{i});
        result(:,:,i) = f * (temp- 128) + 128;
    end
    result = uint8(result);
    figure(11);
    imshow(result);
    imwrite(result,'p1im5_0516222.bmp');
end

function result = adaptive_filter(pic, window)
    new = double(0.2989*pic{1} + 0.5870*pic{2} + 0.1140*pic{3});
    pixel = size(new,1) * size(new,2);
    pad = padarray(new,[floor(window/2),floor(window/2)]);
    local_var = zeros([size(new,1) size(new,2)]);
    local_mean = zeros([size(new,1) size(new,2)]);
    temp = zeros([size(new,1) size(new,2)]);
    result = zeros([size(new,1) size(new,2)]);
    for i = 1:size(pad,1)-(window-1)
        for j = 1:size(pad,2)-(window-1)
            temp = pad(i:i+(window-1),j:j+(window-1));
            tmp =  temp(:);      
            local_mean(i,j) = mean(tmp);
            local_var(i,j) = mean(tmp.^2)-mean(tmp).^2;
        end
    end
    noise_var = sum(local_var(:))/pixel;
    local_var = max(local_var,noise_var); 
    result = noise_var./local_var;
    result = result.*(new-local_mean);
    result = uint8(new-result);
    figure(12);
    imshow(result);
    imwrite(result,'p1im6_0516222.bmp');
end
% 第六章圖原本用的mean filter，但效果不佳
function result = aver(pic)
    new = double(0.2989*pic{1} + 0.5870*pic{2} + 0.1140*pic{3});
    [row, col] = size(pic{1});
    f=zeros([row,col]);
    for index=1:3
        pad = padarray(double(pic{index}),[1,1]);
        for i=1:size(pad,1)-2
            for j=1:size(pad,2)-2
                temp = pad(i,j)+pad(i+1,j)+pad(i+2,j)+pad(i,j+1)+pad(i+1,j+1)+pad(i+2,j+1)+pad(i,j+2)+pad(i+1,j+2)+pad(i+2,j+2);
                f(i,j)=temp/9;
            end
        end
        result(:,:,index) = uint8(f);        
    end
    figure(13);
    imshow(result);
    %imwrite(result,'p1im1_0516222.bmp');
end
