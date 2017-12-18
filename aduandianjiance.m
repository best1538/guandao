% 挖掘的话为350
% 敲击为180或者150

clear
clc
load('D:\20170802123044.mat');
[m,n]=size(data_c1);
data_lvbo=zeros(m,n);%%预先分配内存会特别快。
for i=1:m
    out=cut_wave(data_c1(i,:));
    data_lvbo(i,:)=out;
end
state=[];
 for j=1:m
     data=data_lvbo(j,:);
     state_temp=ayuzhi2(data,150);
     state(j,:)=state_temp;
 end
% save('152420','state')
imagesc(state);  %将矩阵中的元素按数值大小的不同转化成不同颜色，并在坐标轴上对应位置以这种颜色染色。
colormap(flipud(gray)); 
ylabel('1到4096点');xlabel('在130秒内发生入侵的时间')
title('123044_937')
% figure(2)
% waterfall(state)
% [m,n]=size(state);
% c_num=[];
% for i=1:m
%     c=find(state(i,1:n))
%     [~,p]=size(c);
%     c_num(i)=p;
% end
% plot(c_num);
% xlabel('1到4096点');ylabel('在130秒内发生入侵的时间')
% title('123044')




