%实现直方图均衡化
ImageInRGB=imread('G:\大三下\数字图像处理与机器视觉\code_matlab\2\apple2.png');
ImageIn=rgb2gray(ImageInRGB);
ImageGray=0:255;%行向量
ImageBar=ImageGray;
ImageSize=size(ImageIn,1)*size(ImageIn,2);%图像大小
for i = 1:size(ImageGray,2)%求频数
    ImageBar(i)=sum(sum(ImageIn==ImageGray(i)));
end
ImageBar=ImageBar/ImageSize;%计算频率
ImageBarNew=ImageBar;
for i = 2:size(ImageBarNew,2)%计算累积直方图
    ImageBarNew(i)=ImageBarNew(i-1)+ImageBar(i);%技巧
end
bar(ImageGray,ImageBarNew);%累积直方图

%直方图变换
ImageShow=ImageIn;
for i =1:size(ImageIn,1)
    for j = 1:size(ImageIn,2)
        ImageShow(i,j)=uint8(ImageBarNew(ImageIn(i,j)+1)*255);%灰度值对应的灰度值的概率再呈上255
    end
end
%新的直方图
for i =1:size(ImageGray,2)
    ImageBarNew(i)=sum(sum(ImageShow==ImageGray(i)));
end
ImageBarNew=ImageBarNew/ImageSize;%计算频率
subplot(221)
imshow(ImageIn);title('原图像');
subplot(222)
imshow(ImageShow);title('均衡化图像');
subplot(223)
bar(ImageGray,ImageBar);title('原图像直方图');
subplot(224)
bar(ImageGray,ImageBarNew);title('新图像直方图');