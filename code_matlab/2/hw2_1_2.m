%空域低通滤波,噪声点是高通信号
ImageInRGB=imread('G:\大三下\数字图像处理与机器视觉\code_matlab\2\castle.png');
ImageIn=rgb2gray(ImageInRGB);
ImageOut1=ImageIn;
ImageOut2=ImageIn;
ImageIn=double(ImageIn);
operator1=[1/10 1/10 1/10;1/10 1/10 1/10;1/10 1/10 1/10];
operator2=[1/16 1/8 1/16;1/8 1/4 1/8;1/16 1/8 1/16];
for i=2:size(ImageIn,1)-1%采取边界不处理
    for j = 2:size(ImageIn,2)-1
        ImageOut1(i,j)=sum(sum(ImageIn(i-1:i+1,j-1:j+1).*operator1));
    end
end
for i=2:size(ImageIn,1)-1%采取边界不处理
    for j = 2:size(ImageIn,2)-1
        ImageOut2(i,j)=sum(sum(ImageIn(i-1:i+1,j-1:j+1).*operator2));
    end
end
%显示图像
subplot(1,3,1);
imshow(uint8(ImageIn));
title('原图像');
subplot(1,3,2);
imshow(ImageOut1);
title('空域低通滤波算子1');%效果更好一点
subplot(1,3,3);
imshow(ImageOut2);
title('空域低通滤波算子2');