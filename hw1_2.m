%ʵ����ֵ�Ҷȷָ�
ImageInRGB=imread('G:\������\����ͼ����������Ӿ�\code_matlab\2\apple2.png');
ImageIn=rgb2gray(ImageInRGB);
high=200;
low=10;
Threshold=(low<ImageIn)&(ImageIn<high);
subplot(1,2,1);
imshow(ImageIn);
title('ԭͼ��');
subplot(1,2,2);
imshow(Threshold);
title('��ֵ�ָ�');