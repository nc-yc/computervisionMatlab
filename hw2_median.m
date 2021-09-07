%中值滤波
ImageInRGB=imread('G:\大三下\数字图像处理与机器视觉\code_matlab\2\girl_Gaussian.png');
ImageIn=double(rgb2gray(ImageInRGB));
ImageOut=ImageIn;
MedianModelHalfLength=2;
MedianModelSize=(2*MedianModelHalfLength+1)^2;
MedianModelMidelPos=MedianModelHalfLength*MedianModelHalfLength*2+MedianModelHalfLength*2+1;
for i=MedianModelHalfLength+1:size(ImageIn,1)-MedianModelHalfLength%采取边界不处理
    for j = MedianModelHalfLength+1:size(ImageIn,2)-MedianModelHalfLength
        MedianModel=ImageIn(i-MedianModelHalfLength:i+MedianModelHalfLength,j-MedianModelHalfLength:j+MedianModelHalfLength);
        MedianModelLine=reshape(MedianModel,1,MedianModelSize);
        MedianModelLine=sort(MedianModelLine);
        ImageOut(i,j)=MedianModelLine(MedianModelMidelPos);
    end
end
subplot(1,2,1);
imshow(uint8(ImageIn));
title('原图像');
subplot(1,2,2);
imshow(uint8(ImageOut));
title('滤波之后照片');