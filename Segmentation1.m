%�����зֺ���
%�����������ʼ��ַ��������ַ����ʼʱ�䣬����ʱ�䣬�ļ���,·��
%���Ϊ���������.mat�ļ�
%start_address,end_address���0��ʼ����2,3��������1,2
function [data_c1]=Segmentation1(start_time,end_time,start_address,end_address,filename,pathname)
%�ļ�������ʼʱ�䣬����ʱ�䣬��ʼ���ڵ㣬�������ڵ㣨��ʼʱ��Ϳ�ʼ���ڵ㶼�Ǵ�0��ʼ��

[m,~]=size(filename);
% data_use=[];
for z=1:m
   name_file=filename(z,:);

length_1s=4096*2*2*500; %1s���ݴ�С 16bits
fid=fopen([pathname,name_file],'r','l');
fseek(fid,0,'eof');     %��ȡ��ȡ�����ļ��ĳ���  
position=ftell(fid);    %��ȡ��ʱָ���λ��
fseek(fid,0,'bof');
nonzero_position=find(fread(fid,'*uint8')',1);%��ȡ��һ��������������

time_length=floor((position-nonzero_position) /length_1s);%�ж�����
fclose(fid);
use_time=end_time-start_time;
if(time_length<use_time)%��ѡȡ��ʱ���ҪС�ڸ����ݶε��������
    disp('����ʱ��δ��ڸö��������')
end

if((start_time==0)&&(end_time==0))
    end_time=time_length;%����ʼ����ʱ�䶼Ϊ0��Ϊ��ȡһ���ļ���ʼ������ʱ��
end
if((start_address==0)&&(end_address==0))
    end_address=4095;%����ʼ����ʱ�䶼Ϊ0��Ϊ��ȡһ���ļ���4096����
end    
data_c1=[];
% data_c2=[];
fid=fopen([pathname,name_file],'r','l');
read_length=end_address-start_address+1;

for  i=start_time:end_time-1   
    for j=0:500-1              
        fseek(fid,(nonzero_position-1)+i*length_1s+j*4096*2*2+start_address*2,'bof');  %����ʱ������壬��λ��һͨ��������
        part_c1=fread(fid,read_length,'*uint16');
        data_c1=cat(2,data_c1,part_c1);%����ˮƽ����
        
%         fseek(fid,(nonzero_position-1)+i*length_1s+j*4096*2*2+4096*2+start_address*2,'bof');   %����ʱ������壬��λ�ڶ�ͨ��������
%         part_c2=fread(fid,read_length,'*uint16');
%         data_c2=cat(2,data_c2,part_c2);%����ˮƽ����  
    end 
end
fclose(fid);

% data_use=cat(2,data_use,data_c1);%����ˮƽ����
% save([num2str(name_file(1:14)),'.mat'],'data_c1')%�������ݵ���ǰĿ¼��
save('zdata_c1.mat','data_c1')
end
end



