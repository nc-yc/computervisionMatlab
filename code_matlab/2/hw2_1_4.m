%边缘保持滤波
ImageInRGB=imread('G:\大三下\数字图像处理与机器视觉\code_matlab\2\apple.png');
ImageIn=double(rgb2gray(ImageInRGB));
% ImageIn=[0 1 1;0 0 1;0 0 1];
ImageOut=ImageIn;
HalfLength=3;
for i =HalfLength+1:size(ImageIn,1)-HalfLength
    for j =HalfLength+1:size(ImageIn,2)-HalfLength
        average1=ImageIn(i-HalfLength:i,j:j+HalfLength);
        average2=ImageIn(i:i+HalfLength,j:j+HalfLength);
        average3=ImageIn(i-HalfLength:i,j-HalfLength:j);
        average4=ImageIn(i:i+HalfLength,j-HalfLength:j);
        Average=[average1 average2 average3 average4];
        v1=sum(sum(ImageIn(i-HalfLength:i,j:j+HalfLength).^2))-sum(sum(ImageIn(i-HalfLength:i,j:j+HalfLength)))^2/(HalfLength+1)^2;
        v2=sum(sum(ImageIn(i:i+HalfLength,j:j+HalfLength).^2))-sum(sum(ImageIn(i:i+HalfLength,j:j+HalfLength)))^2/(HalfLength+1)^2;
        v3=sum(sum(ImageIn(i-HalfLength:i,j-HalfLength:j).^2))-sum(sum(ImageIn(i-HalfLength:i,j-HalfLength:j)))^2/(HalfLength+1)^2;
        v4=sum(sum(ImageIn(i:i+HalfLength,j-HalfLength:j).^2))-sum(sum(ImageIn(i:i+HalfLength,j-HalfLength:j)))^2/(HalfLength+1)^2;
        [value,index]=min([v1 v2 v3 v4]);
        ImageOut(i,j)=Average(index);
    end
end
subplot(1,2,1);
imshow(uint8(ImageIn));
title('原图像');
subplot(1,2,2);
imshow(uint8(ImageOut));
title('边缘保持');