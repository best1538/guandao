%%test_dataΪ1*n������

function temp_state=svm_test(test_data)
load('svmStruct1_0.mat')
load('svmStruct7_8.mat')
load('svmStruct2_3.mat')
[test_data,y3]=aTeZhengtiqu1(test_data);
temp_state=zeros(1,y3)
aspecies =svmclassify(svmStruct7_8,test_data,'Showplot',true);
aspecies=aspecies';
zhen_th=find(~(aspecies-8));%������һ���ж��ٵ㣬�������񶯵�����ꡣ
[~,n]=size(zhen_th);
if n==0  %��ʾ���n=0����������ִ�С�
    return
end
nest_class1=[];
for i=1:n
    e=zhen_th(i);
    real_data=test_data(e,:);
    nest_class1=cat(1,nest_class1,real_data);
end

bspecies =svmclassify(svmStruct1_0,nest_class1,'Showplot',true);
bspecies=bspecies';
zhen_th2=find(bspecies);%�ҳ�����Ϊ0�������Ա��ܹ��ֳ����û����١�cΪ���صĵ�ַ��
[~,m]=size(zhen_th2);
for i=1:m
    temp_state(zhen_th(zhen_th2(i)))=1
end
cc_th=find(~bspecies);
[~,k]=size(cc_th);
if k==0
    return
end
nest_class2=[];
for i=1:k
    e_temp=cc_th(i);
    temp_data=nest_class1(e_temp,:);
    nest_class2=cat(1,nest_class2,temp_data);
end
cspecies =svmclassify(svmStruct2_3,nest_class2,'Showplot',true);
for i=1:k
    cspecies=cspecies';
    temp_state(zhen_th(cc_th(i)))=cspecies(i)
end

