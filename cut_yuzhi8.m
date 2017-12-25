%对一段数据进行振动检测，返回检测到的有振动的信息段断点信息
%输入数据： 1行N列的数据（不需要进行滤波处理）
%输出数据： 检测到的振动信号端点信息 （一个开始位置 一个结束位置 ，一一对应）
%shreshold_power 检测开始点与结束的能量阈值
%threshold_min_power 补偿开始与结束时间的最小能量阈值

function [start_address,end_address,threshold_power]=cut_yuzhi8(data)

window=100;%做一次计算的数据个数
move_window=60;%做完运算后移动的数据个数

short_time_power=[];%短时能量
%添加进去效果不好，去除
% cross_zero=[];%过零率
% shang=[];%熵
extremely_poor=[];%极差
start_address=[];
end_address=[];
flag=0;% =1表示现在已经是切分的上升期

n=length(data);
n=floor((n-window)/move_window);%数据计算的次数
for j=0:n %一共有n+1个特征数据
    b=double(data(move_window*j+1:move_window*j+window));
    [y_ft,y_p,y_power ]=frequency(b);    
    short_time_power=[short_time_power,sum(y_power)];%短时能量   
    extremely_poor=[extremely_poor,max(b)-min(b)];
%     cross_zero=[cross_zero,cross_zero_rate(b)];%过零率
%     [f,Pxx,entropy_value]=pwelch_shang(b);
%     shang=[shang,entropy_value];%熵
end

% 根据最大能量与平均能量计算出一个能量阈值
%用于最开始一次开始与结束端点阈值确定
threshold_power=(0.55+(max(short_time_power)/mean(short_time_power))/10)*mean(short_time_power);
if threshold_power<2600 
    threshold_power=2600;
end


%对得到的特征数据进行平滑处理
%使用中值滤波
% short_time_power=smooth(short_time_power,'sgolay'); 
short_time_power=smooth(short_time_power,'sgolay'); 
short_time_power=medfilt1(short_time_power,5);
% short_time_power=smooth(short_time_power,4); 



%下面是判断各个点是否满足振动条件
%j=k 代表第K个窗算出来的特征值
%第K个窗对应的点是 move_window*(k-1)+1~move_window*(k-1)+window
% threshold_cross_zero=0.05;
for j=1:n+1
    if flag==1%开始切分，在找结束时间
        if (short_time_power(j)<threshold_power)% ||(cross_zero(j+1)<threshold_cross_zero)%&&(shang(j+1)<threshold_shang)
            end_address=[end_address,j];
            flag=0;
        end
    else %准备开始切分，在找开始时间
        if (short_time_power(j)>threshold_power)% &&(cross_zero(j+1)>threshold_cross_zero)%&&(shang(j+1)>threshold_shang)%开始的条件
            start_address=[start_address,j];
            flag=1;
        end         
    end    
end

%当数据结束时结束还没有到来，就是开始地址和结束地址数量不同
%直接去掉那个多余的开始地址
if flag==1
    jjj=length(start_address);
    start_address(jjj)=[];
end


%下面的计算是将开始前的一段上升与结束后的一段下降也算在切分的数据内
%这样做的目的是可以把开始条件放的严格点，有尖峰才判断有动作
%但是有尖峰有动作会让前一段信息缺失
%所以将尖峰上升与下降的信号也收集起来，增加信号的完整性
%threshold_min_power 这个量值就是为了控制多少值可以添加进来
%threshold_min_power 使用一个软阈值的方式产生
%threshold_min_power ==没有动作时候的平均能量
%这里直接减上面检测到的有动作时间段的数据去除，剩下的全部都是没有动作的（其实是有偏差的）

if length(start_address)>0
    sum_power=sum(short_time_power(1:start_address(1)-1));%没有动作点的总能量
    number=start_address(1);%多少个点没有动作
    i=1;
    while i<length(start_address)
        sum_power=sum_power+sum(short_time_power(end_address(i)+1:start_address(i+1)-1));
        number=number+(start_address(i+1)-end_address(i)-1);
        i=i+1;
    end
    sum_power=sum_power+sum(short_time_power(end_address(i)+1:end));
    number=number+(length(short_time_power)-end_address(i)-1);
    threshold_min_power=sum_power/number;
end

%对开始点和结束点进行调整
%最大调整值 ：15
%意思就是最多向前或向后延展15个滑动穿窗大小
maximum_adjustment_value=25;
if length(start_address)>0
    %对开始点进行调整
    for i=1:length(start_address)
        j=1;
        while j<min(maximum_adjustment_value,start_address(i)) % 解决前6个点就有振动时的程序错误
            %前一点时间的能量比当前时间能量小,但是都大于threshold_min_power
            if (short_time_power(start_address(i))>=short_time_power(start_address(i)-1))&&(short_time_power(start_address(i)-1)>=threshold_min_power)
                start_address(i)=start_address(i)-1;
            else
                break; %跳出while j<min(5,start_address(i)-1)这个循环
            end
            j=j+1;
        end
    end
    %对结束点进行调整
    for i=1:length(end_address)
        j=1;
        while j<min(maximum_adjustment_value,n+1-end_address(i)) % 解决最后10个点就有振的程序错误
            %后一点时间的能量比当前时间能量小,但是都大于threshold_min_power
            if (short_time_power(end_address(i))>=short_time_power(end_address(i)+1))&&(short_time_power(end_address(i)+1)>=threshold_min_power)
                end_address(i)=end_address(i)+1;
            else
                break; %跳出while j<min(5,n+1-end_address(i)) 这个循环
            end
            j=j+1;
        end
    end
end


%当两次切出来的数据离得很近的时候，将两次切出来的数据合在一起
maximum_combined_distance=9;
i=1;
while i<(length(start_address)-1)
    if (start_address(i+1)-end_address(i))<=maximum_combined_distance
        end_address(i)=[];
        start_address(i+1)=[];
    end
    i=i+1;
end

% 切出来的片段太短，直接去除
% minimum_duration=floor(300/move_window);
% i=1;
% while i<(length(start_address)-1)
%     if (end_address(i)-start_address(i))<=minimum_duration
%         start_address(i)=[];        
%         end_address(i)=[];
%     end
%     i=i+1;
% end





%显示出各个值，标出切割点
figure(11);
%短时能量
subplot(3,1,2);
plot(short_time_power,'b');
title('能量');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(short_time_power),max(short_time_power)],'Color','k');
    line([end_address(i),end_address(i)],[min(short_time_power),max(short_time_power)],'Color','r');
end
hold off ;
% %过零率
% subplot(4,1,4);
% plot(cross_zero,'b');
% title('过零率');
% hold on ;
% for i=1:length(start_address)
%     line([start_address(i),start_address(i)],[min(cross_zero),max(cross_zero)],'Color','k');
%     line([end_address(i),end_address(i)],[min(cross_zero),max(cross_zero)],'Color','r');
% end
% hold off ;
%能量熵
% subplot(4,1,3);
% plot(shang,'b');
% title('能量熵');
% hold on ;
% for i=1:length(start_address)
%     line([start_address(i),start_address(i)],[min(shang),max(shang)],'Color','k');
%     line([end_address(i),end_address(i)],[min(shang),max(shang)],'Color','r');
% end
% hold off ;


%极差
subplot(3,1,3);
plot(extremely_poor,'b');
title('极差');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(extremely_poor),max(extremely_poor)],'Color','k');
    line([end_address(i),end_address(i)],[min(extremely_poor),max(extremely_poor)],'Color','r');
end
hold off ;


%从窗口地址到数据点地址
for i=1:length(start_address)
    start_address(i)=(start_address(i)-1)*move_window+1;
    end_address(i)=(end_address(i)-1)*move_window+window; % 0.45是一个补偿系数
end

subplot(3,1,1);
hold off ;
plot(data(),'b');
title('时域信号');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(data),max(data)],'Color','k');
    line([end_address(i),end_address(i)],[min(data),max(data)],'Color','r');
end
hold off;


end
