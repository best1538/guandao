function [m,g,n,h]=ayuzhi4(data,threshold_diff1,threshold_diff2)
number=400;
inc=400;
Data=(enframe(data,number,inc))';
[~,seg]=size(Data);
state=zeros(1,seg);
address1=[];
address2=[];
pt2=rms(Data);%均方差qqa
pt3=max(Data);%峰值
pt4=pt3./pt2;%峰值指标
Data_diff=abs(Data(number/2+1:end,:)-Data(1:number/2,:));
Data_diff=sum(Data_diff)/number/2;
for j=1:seg
    if (pt4(j)>threshold_pt1)
        if(Data_diff(j)>threshold_diff1)
            address1=[address1,j];
        end
    elseif (pt4(j)>threshold_pt2)&&(Data_diff(j)>threshold_diff2)
        address2=[address2,j];
    end
end
[~,m]=size(address1);
[~,n]=size(address2);
if m~=0
    
    recombination=[];
    for i=1:m
        recombination=[recombination,Data(:,address1(i))];
    end
    temp_state=bp_test(recombination);
    for i=1:m
        state(address1(i))=temp_state(i);
        
    end
    [~,g]=size(find(state));
    
elseif m==0
    g=0;
end


if n~=0
    recombination=[];
    for i=1:n
        recombination=[recombination,Data(:,address2(i))];
    end
    temp_state=bp_test(recombination);
    for i=1:n
        state(address2(i))=temp_state(i);
    end
    [~,h]=size(find(state));
elseif n==0
    h=0;
end
end
