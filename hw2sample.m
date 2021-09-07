%均值平滑，
ImageInRGB=imread('G:\大三下\数字图像处理与机器视觉\code_matlab\2\castle.png');
ImageIn=rgb2gray(ImageInRGB);
ImageOut=ImageIn;
ImageIn=double(ImageIn);
MeanOperator=ones(3,3)/9;
iOperator=MeanOperator;
for i=2:size(ImageIn,1)-1%采取边界不处理
    for j = 2:size(ImageIn,2)-1
        ImageOut(i,j)=sum(sum(ImageIn(i-1:i+1,j-1:j+1).*iOperator));
    end
end
%显示图像
subplot(1,2,1);
imshow(uint8(ImageIn));
title('原图像');
subplot(1,2,2);
imshow(ImageOut);
title('均值平滑');
