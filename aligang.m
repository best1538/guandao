clc
clear all
close all
% my_path='I:\�人����������\�人��201702028-���ݶ�-4km������';     %��ȡ�����ļ���·��D:\data\����cot0802_roadbuilding datadatahou640_10yinbao_3gegl5 data560m���û���̤����1.2km��ѹ·��ʩ��
% pathname='J:\�人��201702028-���ݶ�-5km-6km�����ٲ���\';
% filename='20170228100205_C1C2_32768_66666_3_8_pos650_850_t_1_262.sigL';
% dot_T=201; %���ڵ���
% center_line=66;
pathname='I:\�人����������\�人��201702028-���ݶ�-4km������\';
filename='20170228093612_C1C2_32768_66666_3_8_pos473_533_t_1_69.sigL';
dot_T=8192; %���ڵ���
center_line=6;

differ_jump=1;
fid=fopen([pathname,filename],'rb','l');
% % myfile_read1=strcat(my_path,'.dat');
% [filename,pathname]=uigetfile({'*.*';'*CH';'*.dat'},'File Selector');
% fid=fopen([pathname,filename],'rb','l');
Fs=500;

t=1;            %��ȡʱ�䣬ÿ�ζ�ȡ���ݵ�ʱ�䳤��,��


fseek(fid,0,'eof');                     %��ȡ��ȡ�����ļ��ĳ���  
pozition=ftell(fid);
num=floor(pozition/(2*dot_T*t*Fs));
fseek(fid,0,'bof'); 

A_M=[]; %�������ƾ���

for i=1:num
    
    sigall=fread(fid,dot_T*t*Fs,'uint16');   %������
    sigreshape=reshape(sigall,dot_T,[]);%ת������dot-TΪ������ʣ��Ϊ�����ľ���
    sig_matrix_differ=abs(sigreshape(:,1:end-1)-sigreshape(:,2:end));%��һ�м�ȥǰһ�С�
    
    sig_matrix_differ_max=max(sig_matrix_differ);%�ҳ���һ�м�ȥǰһ�е����ֵ
    
%     clear sigall
    signal=sigreshape(center_line,:);
%     clear sigreshape
    Tsignal1=signal(:,differ_jump+1:end);
    signal(:,end-differ_jump+1:end)=[];
    signaldiff=signal-Tsignal1;
%     [f,Pxx,deltF,peak_percent]=FP_sig(signaldiff,Fs);
%    A1=sum(abs(signaldiff(:,1:Fs*1)),2); %�źž���ֵ����������
%    A2=sum(abs(signaldiff(:,Fs*1+1:Fs*2)),2);
%    A3=sum(abs(signaldiff(:,Fs*2+1:Fs*3)),2);
%    A4=sum(abs(signaldiff(:,Fs*3+1:Fs*4)),2);
%    A5=sum(abs(signaldiff(:,Fs*4+4:end)),2);
%    A_m=[A1;A2;A3;A4;A5];
%    A_M=[A_M,A_m];

% 
        figure(1)
        subplot(211)
        plot(signal)
%         ylim([0.8e4,1.7e4])
        title('�۲��ԭʼ�ź�')
        subplot(212)
        plot(abs(signaldiff))
%         ylim([0,5000])
        title('�۲�����ź�')
% %  figure(2)
% %  plot(f,Pxx)
figure(2)
plot(sig_matrix_differ_max)
title('cfut_line')
figure(3)
plot(sigall(1:dot_T*4))
title('ԭʼ�ź�ǰn����')
    pause

end

%     for j=1:span
% 
%         figure(1)
%         plot(A_M(j,:))
%         title(['�ռ�Ϊ��',num2str(j),'/',num2str(span),'����'])
%         pause
% %  figure(2)
% %  plot(f,Pxx)
%         
% 
%     end

