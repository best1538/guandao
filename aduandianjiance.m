% �ھ�Ļ�Ϊ350
% �û�Ϊ180����150

clear
clc
load('D:\20170802123044.mat');
[m,n]=size(data_c1);
data_lvbo=zeros(m,n);%%Ԥ�ȷ����ڴ���ر�졣
for i=1:m
    out=cut_wave(data_c1(i,:));
    data_lvbo(i,:)=out;
end
state=[];
 for j=1:m
     data=data_lvbo(j,:);
     state_temp=ayuzhi2(data,150);
     state(j,:)=state_temp;
 end
% save('152420','state')
imagesc(state);  %�������е�Ԫ�ذ���ֵ��С�Ĳ�ͬת���ɲ�ͬ��ɫ�������������϶�Ӧλ����������ɫȾɫ��
colormap(flipud(gray)); 
ylabel('1��4096��');xlabel('��130���ڷ������ֵ�ʱ��')
title('123044_937')
% figure(2)
% waterfall(state)
% [m,n]=size(state);
% c_num=[];
% for i=1:m
%     c=find(state(i,1:n))
%     [~,p]=size(c);
%     c_num(i)=p;
% end
% plot(c_num);
% xlabel('1��4096��');ylabel('��130���ڷ������ֵ�ʱ��')
% title('123044')




