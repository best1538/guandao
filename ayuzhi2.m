function [state]=ayuzhi2(data,threshold_Rpav_all)

% fs=500 ;  %����Ƶ����500hz
window=1000;%��һ�μ�������ݸ���
move_window=800;%����������ƶ������ݸ���

start_address=[];
end_address=[];
% fx_kurtosis_all=[];
% zero_all=[];
% Ef_all=[];
n=length(data);
n=floor((n-window)/move_window);%���ݼ���Ĵ�������ʵ���϶�һ��
% t_colum=double(move_window/fs);
% t=0:t_colum:t_colum*n;
% aparam=2;
Rpav_all=[];
state=zeros(1,n+1);
b_all=[];
  for j=0:n %һ����n+1����������
      b=double(data(move_window*j+1:move_window*j+window));
%       [~,y_p,~ ]=frequency(b);
%       fx_kurtosis=kurtosis(b);
%       fx_kurtosis_all=[fx_kurtosis_all,fx_kurtosis];
      Rpav=max(b)*window/sum(b);
      Rpav_all=[Rpav_all,Rpav];
      
%       Esum = log10(1+sum(y_p.*y_p)/aparam);   % �����������ֵ
%       prob = y_p/(sum(y_p));		             % �������
%       H = -sum(prob.*log(prob+eps));        % ������ֵ
%       Ef = sqrt(1 + abs(Esum/H));     % �������ر�
%       Ef_all=[Ef_all,Ef];
%       
%       %������
%       c=detrend(b,'constant');
%       zero_data=cross_zero_rate(c);
%       zero_all=[zero_all,zero_data];
      b_all=[b_all,b'];
  end
    flag_a=0;
for j=0:n
    if flag_a==1%��ʼ�з֣��Ѿ����ҽ���ʱ��
        if (Rpav_all(j+1)<threshold_Rpav_all)%&&(cross_zero(j+1)<threshold_cross_zero)&&(shang(j+1)<threshold_shang)
            end_address=[end_address,j+1];%����Ӧ�÷���j+1��
            flag_a=0;
        end
    else %׼����ʼ�з֣����ҿ�ʼʱ��
        if (Rpav_all(j+1)>threshold_Rpav_all)%&&(cross_zero(j+1)>threshold_cross_zero)&&(shang(j+1)>threshold_shang)
            start_address=[start_address,j+1];%����Ӧ�÷���j+1��
            flag_a=1;
        end         
    end    
end
%�����ݽ���ʱ������û�е��������ǿ�ʼ��ַ�ͽ�����ַ������ͬ
%ֱ��ȥ���Ǹ�����Ŀ�ʼ��ַ
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


