%½ð×ÖËþ·¨
ImageInRGB=imread('C:\Users\ZYC\Desktop\for_ASABE\code\yellow.jpg');
ImageIn=(rgb2gray(ImageInRGB));
ImageIn=ImageIn(1:(size(ImageIn,1)-mod(size(ImageIn,1),4)),1:(size(ImageIn,2)-mod(size(ImageIn,2),4)));
ImageOut=ImageIn(1:size(ImageIn,1)/4+1,1:size(ImageIn,2)/4+1);
for i = 1:4:size(ImageIn,1)
    for j = 1:4:size(ImageIn,2)
        i2=uint8(i/4+1);
        j2=uint8(j/4+1);
        ImageOut(i2,j2)=uint8(sum(sum(ImageIn(i:i+3,j:j+3)))/16);
    end
end
ImageIn=ImageOut;
ImageIn=ImageIn(1:(size(ImageIn,1)-mod(size(ImageIn,1),4)),1:(size(ImageIn,2)-mod(size(ImageIn,2),4)));
ImageOut2=ImageIn(1:size(ImageIn,1)/4+1,1:size(ImageIn,2)/4+1);
for i = 1:4:size(ImageIn,1)
    for j = 1:4:size(ImageIn,2)
        i2=uint8(i/4+1);
        j2=uint8(j/4+1);
        ImageOut2(i2,j2)=uint8(sum(sum(ImageIn(i:i+3,j:j+3)))/16);
    end
end
ImageIn=ImageOut2;
ImageIn=ImageIn(1:(size(ImageIn,1)-mod(size(ImageIn,1),4)),1:(size(ImageIn,2)-mod(size(ImageIn,2),4)));
ImageOut3=ImageIn(1:size(ImageIn,1)/4+1,1:size(ImageIn,2)/4+1);
for i = 1:4:size(ImageIn,1)
    for j = 1:4:size(ImageIn,2)
        i2=uint8(i/4+1);
        j2=uint8(j/4+1);
        ImageOut3(i2,j2)=uint8(sum(sum(ImageIn(i:i+3,j:j+3)))/16);
    end
end
subplot(141);
imshow(uint8(ImageInRGB));
title('Ô­Í¼Ïñ');
subplot(142);
imshow(ImageOut);
title('½ð×ÖËþ1');
subplot(143);
imshow(ImageOut2);
title('½ð×ÖËþ2');
subplot(144);
imshow(ImageOut3);
title('½ð×ÖËþ3');