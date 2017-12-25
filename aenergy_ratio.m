%%Ƶ��ռ�� 

% clear 
% clc
% filename='20170803103651_C1C2_32768_100000_2_8.dat';
% start_address=1148
% end_address=1153
% % [start_time,end_time,start_address,end_address]=Segmentation('20170803103651_C1C2_32768_100000_2_8.dat',0,0,610,615);
function [filename,start_address,end_address]=energy_ratio(filename,start_address,end_address)
load('data_c1.mat','data_c1');
for x=0:end_address-start_address
    x=uint16(x);
    n=4;
wpname='db3';
load('data_c1.mat','data_c1');
Data=data_c1(x+1,:);
Data=double(Data);
% Data=Data-mean(Data);
Data=detrend(Data);
wpt=wpdec(Data,n,wpname); 
for i=0:15 
    figure(3); 
    rfs=wprcoef(wpt,[4 i]); 
    subplot(4,4,i+1); 
    plot(rfs); 
    grid on; 
    title(['[4 ',num2str(i),']']); 
    axis([0 65500 min(rfs) max(rfs)]); 
    
end 
 save_p_name=strcat(filename(1:14),'-C1-',num2str(x+start_address),'-C1-',num2str(x+1),'-C1-','Ƶռ��');
 saveas(gcf,['D:\matlab_project\Ƶռ��\',save_p_name], 'jpg');
for i=0:3 
    figure(4); 
    rfs=wprcoef(wpt,[4 i]); 
    subplot(4,1,i+1); 
    plot(rfs); 
    grid on; 
    title(['[4 ',num2str(i),']']); 
    axis([0 65500 min(rfs) max(rfs)]); 
end  
 save_p_name=strcat(filename(1:14),'-C1-',num2str(x+start_address),'-C1-',num2str(x+2),'-C1-','Ƶռ��');
 saveas(gcf,['D:\matlab_project\Ƶռ��\',save_p_name], 'jpg');
 
 e=wenergy(wpt);
 %  E=zeros(1,length(e)); 
 figure(5) 
 bar(e); 
 axis([0 length(e) 0 130]); 
 title(['�� ',num2str(n), ' ��']); 
 for j=1:length(e) 
        text(j-0.2,e(j)+20,num2str(e(j),'%2.2f')); 
 end
 save_p_name=strcat(filename(1:14),'-C1-',num2str(x+start_address),'-C1-',num2str(x+3),'-C1-','Ƶռ��');
 saveas(gcf,['D:\matlab_project\Ƶռ��\',save_p_name], 'jpg');
end
   
end 



%�����

% clear
% pathname='D:\��Ŀ\';%�ļ�·��
% filename='20170803130414_C1C2_32768_100000_2_8.dat'
% % length_1s=4096*2*2*500; %1s���ݴ�С 16bits
% fid=fopen([pathname,filename],'r','l');
% part_c2=fread(fid,3000000,'*uint16');
% N=4096;
% x=part_c2(0*N+1:1*N,1)
% x2=part_c2(1*N+1:2*N,1)
% x=double(x);
% x2=double(x2);
% figure(1);
% plot(x)
% figure(2);
% plot(x2)
% corrcoef(x,x2)



%
% wpt1=wpdec(Data,n,wpname); %�����ݽ���С�����ֽ�
% % plot(wpt1)
% % for i=1:2^n %wpcoef(wpt1,[n,i-1])�����n���i���ڵ��ϵ��
% % E(i)=norm(wpcoef(wpt1,[n,i-1]),2);%���i���ڵ�ķ���ƽ������ʵҲ����ƽ����
% % end
% % E_total=sum(E); %��������
% % for i=1:2^n
% % pfir(i)= E(i)/E_total;%��ÿ���ڵ��Ƶ��ռ��
% % end

