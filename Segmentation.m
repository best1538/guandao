%数据切分函数
%输入参数：文件名，开始地址，结束地址，开始时间，结束时间
%输出结束标识 文件的长度
function [start_time,end_time,start_address,end_address]=Segmentation(start_time,end_time,start_address,end_address)
%文件名，开始时间，结束时间，开始所在点，结束所在点（开始时间和开始所在点都是从0开始）
length_1s=4096*2*2*500; %1s数据大小 16bits
filename='20170802122620_C1C2_32768_100000_2_8.dat';
pathname='I:\项目数据\中卫预警系统项目\数据\二线机械\'
fid=fopen([pathname,filename],'r','l');
fseek(fid,0,'eof');     %获取读取分析文件的长度  
position=ftell(fid);    %读取此时指针的位置
fseek(fid,0,'bof');
nonzero_position=find(fread(fid,'*uint8')',1);%获取第一个非零数的索引

time_length=floor((position-nonzero_position) /length_1s);%有多少秒
fclose(fid);
use_time=end_time-start_time;
if(time_length<use_time)%所选取的时间段要小于该数据段的最大秒数
    disp('输入时间段大于该段最大秒数')
end

if((start_time==0)&&(end_time==0))
    end_time=time_length;%若开始结束时间都为0则为读取一个文件开始到结束时间
end
if((start_address==0)&&(end_address==0))
    end_address=4095;%若开始结束时间都为0则为读取一个文件共4096个点
end    
data_c1=[];
data_c2=[];
fid=fopen([pathname,filename],'r','l');
read_length=end_address-start_address+1;

for  i=start_time:end_time-1   
    for j=0:500-1              
        fseek(fid,(nonzero_position-1)+i*length_1s+j*4096*2*2+start_address*2,'bof');  %根据时间和脉冲，定位第一通道的索引
        part_c1=fread(fid,read_length,'*uint16');
        data_c1=cat(2,data_c1,part_c1);%数组水平连接
        
%         fseek(fid,(nonzero_position-1)+i*length_1s+j*4096*2*2+4096*2+start_address*2,'bof');   %根据时间和脉冲，定位第二通道的索引
%         part_c2=fread(fid,read_length,'*uint16');
%         data_c2=cat(2,data_c2,part_c2);%数组水平连接  
    end 
end
fclose(fid);
save('20170802122620.mat','data_c1')%保存数据到当前目录下
% save('data_c2.mat','data_c2')
end



