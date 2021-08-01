function [r,c,nccImg] = pyramidMatch(img, template, nLevels)
% -------------------------------------------------------------------------
% 采用金字塔匹配算法进行模板匹配
%
% 过程：(1)为待匹配的图像和模板图像创建nLevels层金字塔图像
%       (2)从金字塔最高层开始进行匹配，最高层的要完全扫描匹配，得到的最佳匹配位置
% 后向下层传递（乘以2）；根据传递的位置，在5*5的窗口范围内进行扫描匹配，如此这样
% 直到最低层。
%       (3)匹配时采用的相似性度量为归一化相关系数
%       (4)创建金字塔时进行了降采样（除2），然后用2*2的平滑滤波器进行了处理
% 
% img-- 源图像（这里假设为灰度图）
% template-- 模板图像（假设为灰度图）
% nLevels-- 金字塔层数
% @r,c-- 源图像中最匹配的位置
% @nccImg-- 进行金字塔匹配时每层对应的归一化相关系数图像
%
% Author: L.L.He
% Time: 26/7/2014
%%-------------------------------------------------------------------------
imshow(img);
hold on;
[t_r,t_c] = size(template);
nccImg = cell(nLevels, 1);
% 这里计算待匹配图像和模板的图像金字塔
nStep = 2; %5*5
srcPrad = pyramid(img, nLevels);
temPrad = pyramid(template, nLevels);
[r,c,nccImg{nLevels}] = matchTemplate(srcPrad{nLevels}, temPrad{nLevels});
for i=nLevels-1:-1:1
    r_start = 2*r - floor((size(temPrad{i},1)-1)/2) - nStep;
    r_end = r_start+2*nStep+1;
    c_start = 2*c - floor((size(temPrad{i},2)-1)/2) - nStep;
    c_end = c_start++2*nStep+1;
    [r,c,nccImg{i}] = matchTemplate(srcPrad{i}, temPrad{i},...
                      r_start, r_end, c_start, c_end);
end
c_r = round(t_r/2);
c_c = round(t_c/2);
rectangle('Position',[c-c_c+1,r-c_r+1,t_c,t_r], 'edgecolor', 'r');
end
% -------------------------------------------------------------------------

% =========================================================================
% 模板匹配算法
function [objr, objc, ncc_Img] = matchTemplate(img, template, r_start, ...
                                r_end, c_start, c_end)
[src_r,src_c] = size(img);
[t_r,t_c] = size(template);
if nargin == 2
    r_start = 1;
    r_end = src_r-t_r+1;
    c_start = 1;
    c_end = src_c-t_c+1;
end
% 这里先计算模板图像的归一化图像
norm_Img = normalize(template);
ncc_Img = zeros(r_end-r_start+1, c_end-c_start+1);
c_r = round(t_r/2);
c_c = round(t_c/2);
for r = r_start:r_end
    for c = c_start:c_end
        currPatch = img(r:r+t_r-1,c:c+t_c-1);
        currPatch = normalize(currPatch);
        ncc_Img(r+c_r-1,c+c_c-1) = NCC(norm_Img, currPatch);
    end
end
[val_1,pos] = max(ncc_Img);
[val_2,objc] = max(val_1);
objr= pos(find(val_1==val_2));
end
% =========================================================================

% =========================================================================
% 计算两幅图像的归一化相关系数（一种相似性度量），其绝对值越大表示越相似
function ncc = NCC(img_1, img_2, isNorm)
if ~exist('isNorm','var')
    isNorm = 1;
end
% 判断参数是否是归一化后的图像
if ~isNorm
    img_1 = normalize(img_1);
    img_2 = normalize(img_2);
end
ncc = sum(sum(img_1.*img_2)) ./ size(img_1(:),1);
end
% =========================================================================

% =========================================================================
% 图像归一化
function norm_Img = normalize(img)
if size(img, 3) ~= 1
    img = rgb2gray(img);
end
norm_Img = zeros(size(img));
mu = mean(img(:));
st = max(std(double(img(:))), eps);
norm_Img = bsxfun(@minus, img, mu);
norm_Img = bsxfun(@rdivide, norm_Img, st);
end
% =========================================================================

% =========================================================================
% 计算图像的金字塔，层数由nLevels参数指定,返回一个结构体，其中包含nLevels张图像
function pyImg = pyramid(img, nLevels)
% 创建金字塔中的每一层图像
pyImg = cell(nLevels, 1);
pyImg{1} = img;
for i=2:nLevels
    pyImg{i} = downSample(pyImg{i-1});
end  
end
% =========================================================================

% =========================================================================
% 对图像进行降采样(2*2)并平滑处理
function d_img = downSample(img)
% 如果原图像的行列是基数则补齐
if mod(size(img,1), 2) ~= 0
    img = [img(1,:); img];
end
if mod(size(img,2), 2) ~= 0
    img = [img(:,1), img];
end
[r,c] = size(img);
d_img = zeros(r/2, c/2);
for i=1:2:r
    for j=1:2:c
        x = (i+1)/2;
        y = (j+1)/2;
        d_img(x,y) = sum(sum(img(i:i+1,j:j+1)))/4;
    end
end
end