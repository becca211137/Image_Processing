function code(file)
    for pic_index=1:4
        % 讀取圖片並顯示
        filename = strcat('p1im',num2str(pic_index), '.bmp');
        ori_pic = imread(filename);
%         figure(1);
%         image(ori_pic);
        % 分成r,g,b三通道存起來
        r = double(ori_pic(:,:,1));
        g = double(ori_pic(:,:,2));
        b = double(ori_pic(:,:,3));
        pic = {r,g,b};
        canny(pic,pic_index);
        %log(pic,pic_index);
        %prewitt_filter_vertical(pic);
        %prewitt_filter_45(pic);
    end
end

function result = prewitt_filter_horizen(pic,pic_index)
%     % contrast
%     c = 100;
%     factor = (259 * (c + 255) ) / (255 * (259 - c));
%     for i=1:3
%         temp = pic{i};
%         contrast(:,:,i) = factor * (temp- 128) + 128;
%     end    
%     new = double(0.2989*contrast(:,:,1) + 0.5870*contrast(:,:,2) + 0.1140*contrast(:,:,3));
% 
%     % gamma
%     rate = 3.75;
%     c = 1;
%     for i=1:3
%         temp = pic{i};
%         gamma(:,:,i) = temp/255;
%         gamma(:,:,i) = c * (gamma(:,:,i).^rate);
%         gamma(:,:,i) = gamma(:,:,i)*255;
%     end
%     new = gamma(0.2989*contrast(:,:,1) + 0.5870*gamma(:,:,2) + 0.1140*gamma(:,:,3));
    
    [row, col] = size(pic{1});
    f=zeros([row,col]);
    new = double(0.2989*pic{1} + 0.5870*pic{2} + 0.1140*pic{3});
    % 將邊界補0
    pad = padarray(new,[1,1]);
    for i=1:size(pad,1)-2
        for j=1:size(pad,2)-2
            temp = -pad(i,j)-pad(i,j+1)-pad(i,j+2)+pad(i+2,j)+pad(i+2,j+1)+pad(i+2,j+2);
            f(i,j)=temp;
        end
    end
    % threshold
    f(f>30)=255;
    f(f<30)=0;
    % save picture
    result = uint8(f);
    figure(pic_index);
    imshow(result);    
    filename = strcat('Plim',num2str(pic_index), '.bmp');
    imwrite(result,filename);
    end

function result = log(pic,pic_index)
        % contrast
    c = 100;
    factor = (259 * (c + 255) ) / (255 * (259 - c));
    for i=1:3
        temp = pic{i};
        contrast(:,:,i) = factor * (temp- 128) + 128;
    end    
    new = double(0.2989*contrast(:,:,1) + 0.5870*contrast(:,:,2) + 0.1140*contrast(:,:,3));

%     % gamma
%     rate = 3.75;
%     c = 1;
%     for i=1:3
%         temp = pic{i};
%         gamma(:,:,i) = temp/255;
%         gamma(:,:,i) = c * (gamma(:,:,i).^rate);
%         gamma(:,:,i) = gamma(:,:,i)*255;
%     end
%     new = double(0.2989*gamma(:,:,1) + 0.5870*gamma(:,:,2) + 0.1140*gamma(:,:,3));

    [row, col] = size(pic{1});
    f=zeros([row,col]);
    %new = double(0.2989*pic{1} + 0.5870*pic{2} + 0.1140*pic{3});
    % 將邊界補0
    pad = padarray(new,[2,2]);
    for i=1:size(pad,1)-4
        for j=1:size(pad,2)-4
            temp = -pad(i,j+2)-pad(i+1,j+1)-2*pad(i+1,j+2)-pad(i+1,j+3)-pad(i+2,j)-2*pad(i+2,j+1)+16*pad(i+2,j+2)-2*pad(i+2,j+3)-pad(i+2,j+4)-pad(i+3,j+1)-2*pad(i+3,j+2)-pad(i+3,j+3)-pad(i+4,j+2);
            f(i,j)=temp;
        end
    end
    
    % threshold
    f(f>80)=255;
    f(f<80)=0;
    
    result= uint8(f);     
    figure(pic_index);
    imshow(result);
    filename = strcat('Plim',num2str(pic_index), '.bmp');
    imwrite(result,filename);
end
function result = sobel_filter_horizen(pic,pic_index)
    [row, col] = size(pic);
    f=zeros([row,col]);
    % 將邊界補0
    pad = padarray(pic,[1,1]);
    for i=1:size(pad,1)-2
        for j=1:size(pad,2)-2
            temp = -pad(i,j)-2*pad(i,j+1)-pad(i,j+2)+pad(i+2,j)+2*pad(i+2,j+1)+pad(i+2,j+2);
            f(i,j)=temp;
        end
    end
    result = f;
%     figure(2);
%     imshow(uint8(f));
end
function result = sobel_filter_vertical(pic,pic_index)
    [row, col] = size(pic);
    f=zeros([row,col]);
    % 將邊界補0
    pad = padarray(pic,[1,1]);
    for i=1:size(pad,1)-2
        for j=1:size(pad,2)-2
            temp = -pad(i,j)-2*pad(i+1,j)-pad(i+2,j)+pad(i+2,j)+2*pad(i+1,j+2)+pad(i+2,j+2);
            f(i,j)=temp;
        end
    end
    result = f;
%     figure(3);
%     imshow(uint8(f));
end
function result = canny(pic,pic_index)
    pic = gauss_filter(pic,pic_index);
    sobel_h = sobel_filter_horizen(pic,pic_index);
    sobel_v = sobel_filter_vertical(pic,pic_index);
    % 計算強度
    strength = sqrt(sobel_h.^2 + sobel_v.^2);
%     figure(2);
%     imshow(uint8(strength));
    pad_strength = padarray(strength, [1,1]);
    % 計算角度
    arctan = atand(sobel_h ./ sobel_v);
    % 把第四象限變第二象限 角度0~180
    arctan(arctan<0) = arctan(arctan<0)+180;
    h = size(arctan,1);
    w = size(arctan,2);
    % 分成四個角度
    for i = 1:h
        for j = 1:w
            if arctan(i,j) <= 22.5 | arctan(i,j)>=157.5
                arctan(i,j) = 0;
            elseif arctan(i,j)<=67.5
                arctan(i,j) = 45;
            elseif arctan(i,j)<=112.5
                arctan(i,j)=90;
            else
                arctan(i,j)=135;
            end
        end
    end    
    pad_arctan = padarray(arctan, [1,1]);
    % nonmaxima suppression
    for i = 2:h-1
        for j = 2:w-1
            switch pad_arctan(i,j)
                % 比較左、右
                case {0}
                    if pad_strength(i,j) < pad_strength(i,j+1) | pad_strength(i,j) < pad_strength(i,j-1)
                        pad_strength(i,j) = 0; 
                    end                    
                % 比較右下、左上
                case {45}
                    if pad_strength(i,j) < pad_strength(i+1,j+1) | pad_strength(i,j) < pad_strength(i-1,j-1)
                        pad_strength(i,j) = 0; 
                    end  
                % 比較上下
                case {90}
                    if pad_strength(i,j) < pad_strength(i+1,j) | pad_strength(i,j) < pad_strength(i-1,j)
                        pad_strength(i,j) = 0; 
                    end
                % 比較左下、右上
                case {135}
                    if pad_strength(i,j) < pad_strength(i+1,j-1) | pad_strength(i,j) < pad_strength(i-1,j+1)
                        pad_strength(i,j) = 0; 
                    end       
            end
        end
    end

%     figure(3);
%     imshow(uint8(pad_strength(2:h+1,2:w+1)));
    % double thresholding
    t_h = 25;
    t_l = 10;
    for i = 2 : h-1
        for j = 2 : w-1
           if pad_strength(i,j) < t_l
              pad_strength(i,j) = 0;
           elseif pad_strength(i,j) > t_h
               pad_strength(i,j) = 255;
           else
               if sum(pad_strength(i-1:i+1,j-1:j+1)==255)==0
                   pad_strength(i,j) = 0;
               else
                   pad_strength(i,j) = 255;
               end
           end
        end
    end
    arctan = pad_arctan(2:h+1,2:w+1);
    strength = pad_strength(2:h+1,2:w+1);
%     figure(4);
%     imshow(uint8(strength));
    filename = strcat('Plim',num2str(pic_index), '.bmp');
    imwrite(strength,filename);
end
function result = gauss_filter(pic, pic_index)
    temp = double(0.2989*pic{1} + 0.5870*pic{2} + 0.1140*pic{3});
    pad = padarray(temp,[1,1]);
    for i=1:size(pad,1)-2
        for j=1:size(pad,2)-2
            temp = pad(i,j) + 2*pad(i,j+1) + pad(i,j+2) + 2*pad(i+1,j) + 4*pad(i+1,j+1) + 2*pad(i+1,j+2) + pad(i+2,j) + 2*pad(i+2,j+1) + pad(i+2,j+2);
            f(i,j)=temp/16;
        end
    end  
    result = f;
%     imshow(result);
end