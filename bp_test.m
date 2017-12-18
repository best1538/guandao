
function temp_state=bp_test(test_data)
load('anet.mat')
anet=net;%%当时自变量和bnet一样，在这里做个区分。
load('bnet.mat')
bnet=net;
[x_tezheng,~]=aTeZhengtiqu3(test_data);
[~,n]=size(x_tezheng);
temp_state=zeros(1,n);
Y1 = sim(anet,x_tezheng); 
Y1(Y1>0.5)=1;
Y1(Y1<=0.5)=0;
case10=[0;1];
case1=[1;0;0];
case2=[0;1;0];
temp_zhen_num=[];
temp_data=[];
for i=1:n
    if Y1(:,i)==case10
        temp_zhen_num=[temp_zhen_num,i];
        temp_data=[temp_data,x_tezheng(:,i)];
    end
end
[~,m]=size(temp_data);
if m==0
    return
end
Y2 = sim(bnet,temp_data); 
Y2(Y2>0.5)=1;
Y2(Y2<=0.5)=0;
for i=1:m
    if Y2(:,i)==case1
        temp_state(temp_zhen_num(i))=1;
    else if Y2(:,i)==case2
            temp_state(temp_zhen_num(i))=2;
        else
            temp_state(temp_zhen_num(i))=3;
        end
    end
end
