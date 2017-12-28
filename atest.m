clear
clc
number=500;
threshold_pt1=120;
threshold_pt4=1.05;
thi=787;
load('c.mat','c');
base_c=c(1,:);
base_c2=c(2,:);
filename=['20170730111008_C1C2_32768_100000_2_8'];
[p,~]=size(filename);
pathname='H:\data\';
for z=1:p
    name_file= filename(z,1:14);
    load([pathname name_file '.mat']);%�м��пո�
    data_c1=data_c1';%wΪ65500*4096
    [m,~]=size(data_c1);
    line_number=floor(m/number);
    state1=zeros(4096,line_number);%Ԥ�����ڴ��һ�㡣
    for w=1:line_number
        data1=data_c1((w-1)*number+1:w*number,:);%���Ժ��������˲�����Ҫ�����ı䡣
        [state_temp]=ayuzhi2(data1,number,threshold_pt1,threshold_pt4);
        state1(:,w)=state_temp;
    end
    state1(state1>=1)=1;
    state1(state1<1)=0;
    imagesc(state1);  %�������е�Ԫ�ذ���ֵ��С�Ĳ�ͬת���ɲ�ͬ��ɫ�������������϶�Ӧλ����������ɫȾɫ��
    colormap(flipud(gray));
    ylabel('1��4096��');xlabel('��130���ڷ������ֵ�ʱ��')
    [~,rihgt_dot]=size(find(state1(thi,:)));
    [all_dot,~]=size(find(state1));
    accuracy=rihgt_dot/all_dot;
%     save(strcat('D:\��������\12.25ͼ��mat\','a',num2str(name_file(1:14)),'.mat'),'state');
%     saveas(gcf,strcat('D:\��������\12.25ͼ��mat\','a',num2str(name_file(1:14)),'.tif'));
end

