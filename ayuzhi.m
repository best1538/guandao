function start_address=ayuzhi(data,threshold_Rpav_all)

fs=500 ;  %采样频率是500hz
window=200;%做一次计算的数据个数
move_window=100;%做完运算后移动的数据个数


start_address=[];
end_address=[];
Rpav_all=[];
fx_kurtosis_all=[];
zero_all=[];
Ef_all=[];
n=length(data);

n=floor((n-window)/move_window);%数据计算的次数
t_colum=double(move_window/fs);
t=0:t_colum:t_colum*n;
aparam=2;
b_all=[];
  for j=0:n %一共有n+1个特征数据
      b=double(data(move_window*j+1:move_window*j+window));
      [~,y_p,~ ]=frequency(b);
      fx_kurtosis=kurtosis(b);
      fx_kurtosis_all=[fx_kurtosis_all,fx_kurtosis];
      Rpav=max(b)*window/sum(b);
      Rpav_all=[Rpav_all,Rpav];
      
      Esum = log10(1+sum(y_p.*y_p)/aparam);   % 计算对数能量值
      prob = y_p/(sum(y_p));		             % 计算概率
      H = -sum(prob.*log(prob+eps));        % 求谱熵值
      Ef = sqrt(1 + abs(Esum/H));     % 计算能熵比
      Ef_all=[Ef_all,Ef];
      
      %过零率
      c=detrend(b,'constant');
      zero_data=cross_zero_rate(c);
      zero_all=[zero_all,zero_data];
      b_all=[b_all,b'];
  end
  
  flag_a=0;
for j=0:n
    if flag_a==1%开始切分，已经在找结束时间
        if (Rpav_all(j+1)<threshold_Rpav_all)%&&(cross_zero(j+1)<threshold_cross_zero)&&(shang(j+1)<threshold_shang)
            end_address=[end_address,j];
            flag_a=0;
        end
    else %准备开始切分，在找开始时间
        if (Rpav_all(j+1)>threshold_Rpav_all)%&&(cross_zero(j+1)>threshold_cross_zero)&&(shang(j+1)>threshold_shang)
            start_address=[start_address,j];
            flag_a=1;
        end         
    end    
end

%当数据结束时结束还没有到来，就是开始地址和结束地址数量不同
%直接去掉那个多余的开始地址
if flag_a==1
    jjj=length(start_address);
    start_address(jjj)=[];
end
%
%将横坐标改为时间量度
start_address=start_address*t_colum;
end_address=end_address*t_colum;
%显示出各个值，标出切割点
figure(11);
%短时能量
subplot(5,1,1);
plot(t,Ef_all,'b');
title('能熵比');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(Ef_all),max(Ef_all)],'Color','k');
    line([end_address(i),end_address(i)],[min(Ef_all),max(Ef_all)],'Color','r');
end
hold off ;
%过零率
subplot(5,1,2);
plot(t,zero_all,'b');
title('过零率');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(zero_all),max(zero_all)],'Color','k');
    line([end_address(i),end_address(i)],[min(zero_all),max(zero_all)],'Color','r');
end
hold off ;
%能量熵
subplot(5,1,3);
plot(t,fx_kurtosis_all,'b');
title('峭度');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(fx_kurtosis_all),max(fx_kurtosis_all)],'Color','k');
    line([end_address(i),end_address(i)],[min(fx_kurtosis_all),max(fx_kurtosis_all)],'Color','r');
end
hold off ;

subplot(5,1,4);
hold off ;
plot(t,Rpav_all,'b');
title('峰均比');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(Rpav_all),max(Rpav_all)],'Color','k');
    line([end_address(i),end_address(i)],[min(Rpav_all),max(Rpav_all)],'Color','r');
end


[~,n]=size(b_all);
data_1=[];
for i=1:n-1
    data_diff=sum(abs(b_all(:,i+1)-b_all(:,i)));
    data_1=cat(2,data_1,data_diff);
end
data_1=[data_1,data_1(:,end)];
subplot(5,1,5);
hold off ;
plot(t,data_1,'b');
title('峰均比');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(data_1),max(data_1)],'Color','k');
    line([end_address(i),end_address(i)],[min(data_1),max(data_1)],'Color','r');
end

end
