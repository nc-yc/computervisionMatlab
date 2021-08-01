%迭代式阈值选择，背景图上面显示过分割，欠分割
%1对象叠加在原图上，看对象是否露出来，看是否有前分割现象
%2背景叠加在原图上
ImageInRGB=imread('G:\大三下\数字图像处理与机器视觉\code_matlab\2\apple2.png');
ImageIn=(rgb2gray(ImageInRGB));
% imshow(ImageIn);
%创建直方图
ImageGray=0:255;
ImageBar=ImageGray;
for i=1:size(ImageGray,2)%求频数
    ImageBar(i)=sum(sum(ImageIn==ImageGray(i)));
end
% bar(ImageGray,ImageBar);%直方图

ImageBarBig0=find(ImageBar>0);%找出图像上有像素点的
Th=round((ImageBarBig0(1)+ImageBarBig0(end))/2);%阈值初始化
ImageIn=double(ImageIn);

u1=sum(ImageBar(1:Th+1).*(0:Th))/sum(ImageBar(1:Th+1));%利用直方图进行计算
u2=sum(ImageBar(Th+2:256).*(Th+1:255))/sum(ImageBar(Th+2:256));


u1_old=u1-1;%保证进入循环
while u1_old~=u1
    u1_old=u1;
    u2_old=u2;
    Th=round((u1+u2)/2);
    u1=sum(ImageBar(1:Th+1).*(0:Th))/sum(ImageBar(1:Th+1));
    u2=sum(ImageBar(Th+2:256).*(Th+1:255))/sum(ImageBar(Th+2:256));
end

ImageOut0=ImageIn>Th;
ImageIn0=ImageIn;
ImageOut=uint8(ImageIn>Th)*255;
ImageIn=uint8(ImageIn);

subplot(131);
imshow(ImageIn);
title('原图像');
subplot(132);
imshow(ImageOut);
title('迭代分割');
subplot(133);
imshow(uint8(ImageOut0.*ImageIn0));
title('分割效果');