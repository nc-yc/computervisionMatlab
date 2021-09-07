%最大类间方差
ImageInRGB=imread('G:\大三下\数字图像处理与机器视觉\code_matlab\2\apple2.png');
ImageIn=double(rgb2gray(ImageInRGB));
ImageGray=0:255;
ImageBar=zeros(1,256);
for i1=1:size(ImageIn,1)
    for i2=1:size(ImageIn,2)
        ImageBar(ImageIn(i1,i2)+1)=ImageBar(ImageIn(i1,i2)+1)+1;
    end
end
SumALL=sum(ImageGray.*ImageBar);
nAII=size(ImageIn,1)*size(ImageIn,2);
SdList=zeros(256,1);
for i1=2:size(ImageGray,2)-1
    n0=sum(ImageBar(1:i1));
    Sum0=sum(ImageGray(1:i1).*ImageBar(1:i1));
    n1=nAII-n0;
    Sum1=SumALL-Sum0;
    if n0>0&&n1>0
        u0=Sum0/n0;
        u1=Sum1/n1;
        SdList(i1)=n0*n1*(u0-u1)^2;
    end
end
Th=find(SdList==max(SdList));

ImageOut0=ImageIn>Th;
ImageIn0=ImageIn;
ImageOut=uint8(ImageIn>Th)*255;
ImageIn=uint8(ImageIn);

subplot(131);
imshow(ImageIn);
title('原图像');
subplot(132);
imshow(ImageOut);
title('最大类间方差分割');
subplot(133);
imshow(uint8(ImageOut0.*ImageIn0));
title('分割效果');