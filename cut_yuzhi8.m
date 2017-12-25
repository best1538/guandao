%��һ�����ݽ����񶯼�⣬���ؼ�⵽�����񶯵���Ϣ�ζϵ���Ϣ
%�������ݣ� 1��N�е����ݣ�����Ҫ�����˲�����
%������ݣ� ��⵽�����źŶ˵���Ϣ ��һ����ʼλ�� һ������λ�� ��һһ��Ӧ��
%shreshold_power ��⿪ʼ���������������ֵ
%threshold_min_power ������ʼ�����ʱ�����С������ֵ

function [start_address,end_address,threshold_power]=cut_yuzhi8(data)

window=100;%��һ�μ�������ݸ���
move_window=60;%����������ƶ������ݸ���

short_time_power=[];%��ʱ����
%��ӽ�ȥЧ�����ã�ȥ��
% cross_zero=[];%������
% shang=[];%��
extremely_poor=[];%����
start_address=[];
end_address=[];
flag=0;% =1��ʾ�����Ѿ����зֵ�������

n=length(data);
n=floor((n-window)/move_window);%���ݼ���Ĵ���
for j=0:n %һ����n+1����������
    b=double(data(move_window*j+1:move_window*j+window));
    [y_ft,y_p,y_power ]=frequency(b);    
    short_time_power=[short_time_power,sum(y_power)];%��ʱ����   
    extremely_poor=[extremely_poor,max(b)-min(b)];
%     cross_zero=[cross_zero,cross_zero_rate(b)];%������
%     [f,Pxx,entropy_value]=pwelch_shang(b);
%     shang=[shang,entropy_value];%��
end

% �������������ƽ�����������һ��������ֵ
%�����ʼһ�ο�ʼ������˵���ֵȷ��
threshold_power=(0.55+(max(short_time_power)/mean(short_time_power))/10)*mean(short_time_power);
if threshold_power<2600 
    threshold_power=2600;
end


%�Եõ����������ݽ���ƽ������
%ʹ����ֵ�˲�
% short_time_power=smooth(short_time_power,'sgolay'); 
short_time_power=smooth(short_time_power,'sgolay'); 
short_time_power=medfilt1(short_time_power,5);
% short_time_power=smooth(short_time_power,4); 



%�������жϸ������Ƿ�����������
%j=k �����K���������������ֵ
%��K������Ӧ�ĵ��� move_window*(k-1)+1~move_window*(k-1)+window
% threshold_cross_zero=0.05;
for j=1:n+1
    if flag==1%��ʼ�з֣����ҽ���ʱ��
        if (short_time_power(j)<threshold_power)% ||(cross_zero(j+1)<threshold_cross_zero)%&&(shang(j+1)<threshold_shang)
            end_address=[end_address,j];
            flag=0;
        end
    else %׼����ʼ�з֣����ҿ�ʼʱ��
        if (short_time_power(j)>threshold_power)% &&(cross_zero(j+1)>threshold_cross_zero)%&&(shang(j+1)>threshold_shang)%��ʼ������
            start_address=[start_address,j];
            flag=1;
        end         
    end    
end

%�����ݽ���ʱ������û�е��������ǿ�ʼ��ַ�ͽ�����ַ������ͬ
%ֱ��ȥ���Ǹ�����Ŀ�ʼ��ַ
if flag==1
    jjj=length(start_address);
    start_address(jjj)=[];
end


%����ļ����ǽ���ʼǰ��һ��������������һ���½�Ҳ�����зֵ�������
%��������Ŀ���ǿ��԰ѿ�ʼ�����ŵ��ϸ�㣬�м����ж��ж���
%�����м���ж�������ǰһ����Ϣȱʧ
%���Խ�����������½����ź�Ҳ�ռ������������źŵ�������
%threshold_min_power �����ֵ����Ϊ�˿��ƶ���ֵ������ӽ���
%threshold_min_power ʹ��һ������ֵ�ķ�ʽ����
%threshold_min_power ==û�ж���ʱ���ƽ������
%����ֱ�Ӽ������⵽���ж���ʱ��ε�����ȥ����ʣ�µ�ȫ������û�ж����ģ���ʵ����ƫ��ģ�

if length(start_address)>0
    sum_power=sum(short_time_power(1:start_address(1)-1));%û�ж������������
    number=start_address(1);%���ٸ���û�ж���
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

%�Կ�ʼ��ͽ�������е���
%������ֵ ��15
%��˼���������ǰ�������չ15������������С
maximum_adjustment_value=25;
if length(start_address)>0
    %�Կ�ʼ����е���
    for i=1:length(start_address)
        j=1;
        while j<min(maximum_adjustment_value,start_address(i)) % ���ǰ6���������ʱ�ĳ������
            %ǰһ��ʱ��������ȵ�ǰʱ������С,���Ƕ�����threshold_min_power
            if (short_time_power(start_address(i))>=short_time_power(start_address(i)-1))&&(short_time_power(start_address(i)-1)>=threshold_min_power)
                start_address(i)=start_address(i)-1;
            else
                break; %����while j<min(5,start_address(i)-1)���ѭ��
            end
            j=j+1;
        end
    end
    %�Խ�������е���
    for i=1:length(end_address)
        j=1;
        while j<min(maximum_adjustment_value,n+1-end_address(i)) % ������10���������ĳ������
            %��һ��ʱ��������ȵ�ǰʱ������С,���Ƕ�����threshold_min_power
            if (short_time_power(end_address(i))>=short_time_power(end_address(i)+1))&&(short_time_power(end_address(i)+1)>=threshold_min_power)
                end_address(i)=end_address(i)+1;
            else
                break; %����while j<min(5,n+1-end_address(i)) ���ѭ��
            end
            j=j+1;
        end
    end
end


%�������г�����������úܽ���ʱ�򣬽������г��������ݺ���һ��
maximum_combined_distance=9;
i=1;
while i<(length(start_address)-1)
    if (start_address(i+1)-end_address(i))<=maximum_combined_distance
        end_address(i)=[];
        start_address(i+1)=[];
    end
    i=i+1;
end

% �г�����Ƭ��̫�̣�ֱ��ȥ��
% minimum_duration=floor(300/move_window);
% i=1;
% while i<(length(start_address)-1)
%     if (end_address(i)-start_address(i))<=minimum_duration
%         start_address(i)=[];        
%         end_address(i)=[];
%     end
%     i=i+1;
% end





%��ʾ������ֵ������и��
figure(11);
%��ʱ����
subplot(3,1,2);
plot(short_time_power,'b');
title('����');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(short_time_power),max(short_time_power)],'Color','k');
    line([end_address(i),end_address(i)],[min(short_time_power),max(short_time_power)],'Color','r');
end
hold off ;
% %������
% subplot(4,1,4);
% plot(cross_zero,'b');
% title('������');
% hold on ;
% for i=1:length(start_address)
%     line([start_address(i),start_address(i)],[min(cross_zero),max(cross_zero)],'Color','k');
%     line([end_address(i),end_address(i)],[min(cross_zero),max(cross_zero)],'Color','r');
% end
% hold off ;
%������
% subplot(4,1,3);
% plot(shang,'b');
% title('������');
% hold on ;
% for i=1:length(start_address)
%     line([start_address(i),start_address(i)],[min(shang),max(shang)],'Color','k');
%     line([end_address(i),end_address(i)],[min(shang),max(shang)],'Color','r');
% end
% hold off ;


%����
subplot(3,1,3);
plot(extremely_poor,'b');
title('����');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(extremely_poor),max(extremely_poor)],'Color','k');
    line([end_address(i),end_address(i)],[min(extremely_poor),max(extremely_poor)],'Color','r');
end
hold off ;


%�Ӵ��ڵ�ַ�����ݵ��ַ
for i=1:length(start_address)
    start_address(i)=(start_address(i)-1)*move_window+1;
    end_address(i)=(end_address(i)-1)*move_window+window; % 0.45��һ������ϵ��
end

subplot(3,1,1);
hold off ;
plot(data(),'b');
title('ʱ���ź�');
hold on ;
for i=1:length(start_address)
    line([start_address(i),start_address(i)],[min(data),max(data)],'Color','k');
    line([end_address(i),end_address(i)],[min(data),max(data)],'Color','r');
end
hold off;


end
