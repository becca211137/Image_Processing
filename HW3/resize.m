img=imread('test.png');
cd=im2double(img);
cd=imresize(cd,1/2);
imwrite(cd,'test3.jpg','Quality',100);