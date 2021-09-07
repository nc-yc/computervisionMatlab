%计算MER
I=imread('apple2.png');
bw=im2bw(I); %#ok<*IM2BW>
bw=~bw;
areas=zeros(1,90);
for i = 1:90
    bw2=imrotate(bw,i,'crop');
    [~,~,area] = minrectangle(bw2);
    areas(i)=area;
end
%面积最小的时候
[area_value,index]=min(areas);
bw2=imrotate(bw,index,'crop');
[rectx,recty,area] = minrectangle(bw2);
subplot(131)
imshow(I);
title('原图像');
subplot(132)
imshow(bw);
title('0°');
subplot(133)
imshow(bw2);
title('60°');
hold on
line(rectx,recty);
%实现函数
function [rectx,recty,area] = minrectangle(image)
[y,x]=find(image==1);%寻找索引的函数
%找出最左边的点
[value,index]=min(x);
left=[value,y(index)];
%最右面的点
[value,index]=max(x);
right=[value,y(index)];
%最下面的点
[value,index]=max(y);
down=[x(index),value];
%最上面的点
[value,index]=min(y);
top=[x(index),value];
%画出外接矩形
rectx=[left(1);left(1);right(1);right(1);left(1)];
recty=[down(2);top(2);top(2);down(2);down(2)];
width=abs(top(2)-down(2));
length=abs(left(1)-right(1));
area=width*length;%外接矩形的面积
end