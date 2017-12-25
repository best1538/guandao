function out=cross_zero_rate(data)
m=length(data);
counter=0;
for i=1:m-1
    if ((data(i)>0)&&(data(i+1)<0)) ||((data(i)<0)&&(data(i+1)>0))
        counter=counter+1;
    end
end
out=counter/(m-1);
end