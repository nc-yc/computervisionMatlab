%阈值平滑
ImageInRGB=imread('G:\大三下\数字图像处理与机器视觉\code_matlab\2\castle.png');
ImageIn=rgb2gray(ImageInRGB);
ImageIn=double(ImageIn);
ImageOut=ImageIn;
MeanOperator=ones(3,3)/9;
iOperator=MeanOperator;
T=20;%设置阈值
for i=2:size(ImageIn,1)-1%采取边界不处理
    for j = 2:size(ImageIn,2)-1
        if abs(ImageOut(i,j)-sum(sum(ImageIn(i-1:i+1,j-1:j+1).*iOperator)))>=T
            ImageOut(i,j)=sum(sum(ImageIn(i-1:i+1,j-1:j+1).*iOperator));
        end
    end
end
%显示图像
subplot(1,2,1);
imshow(uint8(ImageIn));
title('原图像');
subplot(1,2,2);
imshow(uint8(ImageOut));
title('阈值平滑');%和简单的均值平滑做对比
