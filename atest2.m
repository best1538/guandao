% �ھ�Ļ�Ϊ350
% �û�Ϊ180����150

clear
clc
filename=[ '20170802123044'];
[p,~]=size(filename);
pathname='H:\ͨ������\';
name_file= filename(1,1:14);
load([pathname name_file '.mat']);%�м��пո�
data_c1=data_c1';
[m,~]=size(data_c1);
num=floor(m/500);
data1=zeros(150,4096);
dot=500;
for i=1:num
    data=data_c1((i-1)*dot+1:i*dot,:);
    Sp = abs(fft(data));                % FFT�任ȡ��ֵ
    Sp = Sp(2:dot/2+1,:);
    sp=log(std(Sp));
    data1(i,:)=sp;
end
data1(data1<9.7)=0;
data1(data1>9.7)=1;
% data=zeros(4096,400);
% for i=1:4096;
% Data=data_c1(i,:);
% number=500;
% inc=200;
% Data=(enframe(Data,number,inc))';
% [~,n]=size(Data);
% Sp = abs(fft(Data));                % FFT�任ȡ��ֵ
% Sp = Sp(2:number/2+1,:);
% sp=log(std(Sp));
% sp(sp<9.3)=0;
% sp(sp>9.3)=1;
% data(i,1:n)=sp;
% % plot(sp);
% % T=min(sp)+0.38*(max(sp)-min(sp))
% end





