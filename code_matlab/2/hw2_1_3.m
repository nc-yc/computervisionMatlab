%高斯平滑滤波，边界不处理
%首先构造高斯滤波器
GaussianModelSD=10;
GaussianModelHalfLength=7;
GaussianModel=zeros(2*GaussianModelHalfLength+1);
for i =-GaussianModelHalfLength:GaussianModelHalfLength
    for j=-GaussianModelHalfLength:GaussianModelHalfLength
        GaussianModel(i+GaussianModelHalfLength+1,j+GaussianModelHalfLength+1)=...
            exp(-(i*i+j*j)/(2*GaussianModelSD*GaussianModelSD));
    end
end
% GaussianModel=GaussianModel/GaussianModel(1,1)*2;%都变成白色了
GaussianModel=GaussianModel/sum(sum(GaussianModel));%对高斯滤波器进行归一化
ImageInRGB=imread('G:\大三下\数字图像处理与机器视觉\code_matlab\2\girl_Gaussian.png');
ImageIn=double(rgb2gray(ImageInRGB));
ImageOut=ImageIn;
for i=GaussianModelHalfLength+1:size(ImageIn,1)-GaussianModelHalfLength%采取边界不处理
    for j = GaussianModelHalfLength+1:size(ImageIn,2)-GaussianModelHalfLength
        ImageOut(i,j)=sum(sum(ImageIn(i-GaussianModelHalfLength:i+GaussianModelHalfLength,j-GaussianModelHalfLength:j+GaussianModelHalfLength).*GaussianModel));
    end
end
subplot(1,3,1);
imshow(uint8(ImageIn));
title('原图像');
subplot(1,3,2);
mesh(GaussianModel);
title('高斯滤波器');%效果更好一点
subplot(1,3,3);
imshow(uint8(ImageOut));
title('滤波之后照片');