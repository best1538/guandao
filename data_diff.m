function Data_diff=data_diff(Data)
number=1000;
Data_diff=abs(Data(number/2+1:end,:)-Data(1:number/2,:));
Data_diff=sum(Data_diff)/number/2;
end