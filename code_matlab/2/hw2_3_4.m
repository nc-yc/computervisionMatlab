%线检测
ImageWidth=100;
ImageHeight=100;
ImageData=zeros(ImageHeight,ImageWidth)+1;
LineLength=ImageWidth-10;
LineStartX=5;
LineStartY=25;
ImageData(LineStartY,LineStartX:LineStartX+LineLength-1)=5;
imshow(ImageData-1);
LineMode_0=[-1 -1 -1;2 2 2;-1 -1 -1];
LineMode_45=[-1 -1 2;-1 2 -1;2 -1 -1];
LineMode_90=[-1 2 -1;-1 2 -1;-1 2 -1];
LineMode_135=[2 -1 -1;-1 2 -1;-1 -1 2];
LineDetect_0=ImageData*0;
LineDetect_45=LineDetect_0;
LineDetect_90=LineDetect_0;
LineDetect_135=LineDetect_0;

for i = 1:ImageHeight-size(LineMode_0,1)+1
    for j = 1:ImageWidth-size(LineMode_0,2)+1
        LineDetect_0(i+1,j+1)=sum(sum(LineMode_0.*ImageData(i:i+size(LineMode_0,1)-1,j:j+size(LineMode_0,2)-1)));
        LineDetect_45(i+1,j+1)=sum(sum(LineMode_45.*ImageData(i:i+size(LineMode_45,1)-1,j:j+size(LineMode_45,2)-1)));
        LineDetect_90(i+1,j+1)=sum(sum(LineMode_90.*ImageData(i:i+size(LineMode_90,1)-1,j:j+size(LineMode_90,2)-1)));
        LineDetect_135(i+1,j+1)=sum(sum(LineMode_135.*ImageData(i:i+size(LineMode_135,1)-1,j:j+size(LineMode_135,2)-1)));
    end
end
subplot(221);
imshow(LineDetect_0);
title('0度');
subplot(222);
imshow(LineDetect_45);
title('45度');
subplot(223);
imshow(LineDetect_90);
title('90度');
subplot(224);
imshow(LineDetect_135);
title('135度');
    