
function temp_state=bp_test1(test_data)
load('b_400_200net.mat')
bnet=net;
[x_tezheng,~]=aTeZhengtiqu3(test_data);
[~,n]=size(x_tezheng);
temp_state=zeros(1,n);
Y2 = sim(bnet,x_tezheng); 
Y2(Y2>0.5)=1;
Y2(Y2<=0.5)=0;
case0=[1;0;0];
case1=[0;1;0];
case2=[0;0;1];
for i=1:n
    if Y2(:,i)==case0;
        temp_state(i)=1;
    else if Y2(:,i)==case1;
            temp_state(i)=2;
        else
            temp_state(i)=3;
        end
    end
end
