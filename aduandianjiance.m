% 挖掘的话为350
% 敲击为180或者150

clear
clc
number=500;
threshold_pt1=110;
threshold_dvar=0.9*10^7;
filename=[
'20170730101109_C1C2_32768_100000_2_8'];
[p,~]=size(filename);
pathname='H:\data\';
for z=1:p
    name_file= filename(z,1:14);
    load([pathname name_file '.mat']);%中间有空格
    [m,n]=size(data_c1);
    state1=zeros(4096,400);%预先留内存大一点。
%     state2=zeros(4096,200);%预先留内存大一点。
    for w=787:787
        data1=data_c1(w,:);%若以后这里用滤波函数要发生改变。
        [state_temp]=ayuzhi2(data1,number,threshold_pt1,threshold_dvar);
        state1(w,1:seg)=state_temp;
%         data2=data_c2(j,:);%若以后这里用滤波函数要发生改变。
%         [state_temp,seg]=ayuzhi2(data2,150);
%         state2(j,1:seg)=state_temp;
    end
%     state=state1|state2;
%     restate=zeros(4096,seg);
%     for i=1:4096
%         number=8;5
%         inc=8;
%         redata=(enframe(state(i,1:seg),number,inc))';
%         [~,m]=size(redata);
%         data_sum=sum(redata);
%         e=find(data_sum>=4);
%         [~,b]=size(e);
%         f=zeros(number,m);
%         for j=1:b
%             f(:,e(j))=ones(number,1);
%         end
%         restate(i,1:number*m)=reshape(f,1,number*m);
%     end
    state1(state1>=1)=1;
    state1(state1<1)=0;
    imagesc(state1);  %将矩阵中的元素按数值大小的不同转化成不同颜色，并在坐标轴上对应位置以这种颜色染色。
    colormap(flipud(gray));
    ylabel('1到4096点');xlabel('在130秒内发生入侵的时间')
%     save(strcat('D:\处理数据\12.25图和mat\','a',num2str(name_file(1:14)),'.mat'),'state');
%     saveas(gcf,strcat('D:\处理数据\12.25图和mat\','a',num2str(name_file(1:14)),'.tif'));
end

