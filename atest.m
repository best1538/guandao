clear
clc
number=500;
threshold_pt1=120;
threshold_pt4=1.05;
thi=787;
load('c.mat','c');
base_c=c(1,:);
base_c2=c(2,:);
filename=['20170730111008_C1C2_32768_100000_2_8'];
[p,~]=size(filename);
pathname='H:\data\';
for z=1:p
    name_file= filename(z,1:14);
    load([pathname name_file '.mat']);%中间有空格
    data_c1=data_c1';%w为65500*4096
    [m,~]=size(data_c1);
    line_number=floor(m/number);
    state1=zeros(4096,line_number);%预先留内存大一点。
    for w=1:line_number
        data1=data_c1((w-1)*number+1:w*number,:);%若以后这里用滤波函数要发生改变。
        [state_temp]=ayuzhi2(data1,number,threshold_pt1,threshold_pt4);
        state1(:,w)=state_temp;
    end
    state1(state1>=1)=1;
    state1(state1<1)=0;
    imagesc(state1);  %将矩阵中的元素按数值大小的不同转化成不同颜色，并在坐标轴上对应位置以这种颜色染色。
    colormap(flipud(gray));
    ylabel('1到4096点');xlabel('在130秒内发生入侵的时间')
    [~,rihgt_dot]=size(find(state1(thi,:)));
    [all_dot,~]=size(find(state1));
    accuracy=rihgt_dot/all_dot;
%     save(strcat('D:\处理数据\12.25图和mat\','a',num2str(name_file(1:14)),'.mat'),'state');
%     saveas(gcf,strcat('D:\处理数据\12.25图和mat\','a',num2str(name_file(1:14)),'.tif'));
end

