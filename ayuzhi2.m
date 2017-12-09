function [state]=ayuzhi2(data,threshold_Rpav_all)

% fs=500 ;  %采样频率是500hz
window=1000;%做一次计算的数据个数
move_window=800;%做完运算后移动的数据个数

start_address=[];
end_address=[];
% fx_kurtosis_all=[];
% zero_all=[];
% Ef_all=[];
n=length(data);
n=floor((n-window)/move_window);%数据计算的次数这里实际上多一个
% t_colum=double(move_window/fs);
% t=0:t_colum:t_colum*n;
% aparam=2;
Rpav_all=[];
state=zeros(1,n+1);
b_all=[];
  for j=0:n %一共有n+1个特征数据
      b=double(data(move_window*j+1:move_window*j+window));
%       [~,y_p,~ ]=frequency(b);
%       fx_kurtosis=kurtosis(b);
%       fx_kurtosis_all=[fx_kurtosis_all,fx_kurtosis];
      Rpav=max(b)*window/sum(b);
      Rpav_all=[Rpav_all,Rpav];
      
%       Esum = log10(1+sum(y_p.*y_p)/aparam);   % 计算对数能量值
%       prob = y_p/(sum(y_p));		             % 计算概率
%       H = -sum(prob.*log(prob+eps));        % 求谱熵值
%       Ef = sqrt(1 + abs(Esum/H));     % 计算能熵比
%       Ef_all=[Ef_all,Ef];
%       
%       %过零率
%       c=detrend(b,'constant');
%       zero_data=cross_zero_rate(c);
%       zero_all=[zero_all,zero_data];
      b_all=[b_all,b'];
  end
    flag_a=0;
for j=0:n
    if flag_a==1%开始切分，已经在找结束时间
        if (Rpav_all(j+1)<threshold_Rpav_all)%&&(cross_zero(j+1)<threshold_cross_zero)&&(shang(j+1)<threshold_shang)
            end_address=[end_address,j+1];%这里应该返回j+1；
            flag_a=0;
        end
    else %准备开始切分，在找开始时间
        if (Rpav_all(j+1)>threshold_Rpav_all)%&&(cross_zero(j+1)>threshold_cross_zero)&&(shang(j+1)>threshold_shang)
            start_address=[start_address,j+1];%这里应该返回j+1；
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
address=[start_address;end_address]';
[m,~]=size(address);
if m==0
    return
end
recombination=[];
address_duration_all=[];
for i=1:m
    line_num=address(i,:);
    start_time=line_num(1);
    end_time=line_num(2);
    time_duration=start_time:end_time;
    address_duration_all=[address_duration_all,time_duration];
    recombination=[recombination,b_all(:,start_time:end_time)];
      
end
[~,n]=size(address_duration_all);
temp_state=svm_test(recombination);
for i=1:n
 state(address_duration_all(i))=temp_state(i);   
end


