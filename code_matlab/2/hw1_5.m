a=[1 1 1 1;1 1 4 1;1 1 1 1;1 1 1 1];%给定图像
b=[-1 -1 -1;-1 8 -1;-1 -1 -1];%卷积模板
%方法1：边界不处理
result1=a;
for i = (size(b,1)-1)/2+1:size(a,1)-(size(b,1)-1)/2
    for j = (size(b,2)-1)/2+1:size(a,2)-(size(b,2)-1)/2
        result1(i,j)=sum(sum(a(i-1:i+1,j-1:j+1).*b));
    end
end
%方法2：边界置零
a2=zeros(size(a,1)+(size(b,1)-1),size(a,2)+(size(b,2)-1));
result2=a2;
a2((size(b,1)-1)/2+1:size(a2,1)-(size(b,1)-1)/2,...
        (size(b,2)-1)/2+1:size(a2,2)-(size(b,2)-1)/2)=a;
for i = (size(b,1)-1)/2+1:size(a2,1)-(size(b,1)-1)/2
    for j = (size(b,2)-1)/2+1:size(a2,2)-(size(b,2)-1)/2
        result2(i,j)=sum(sum(a2(i-1:i+1,j-1:j+1).*b));
    end
end
subplot(1,3,1);
imshow(a);
title('原图像');
subplot(1,3,2);
imshow(result1);
title('边界不处理');
subplot(1,3,3);
imshow(result2);
title('边界置零');