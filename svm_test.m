%%test_dataÎª1000*nµÄ¾ØÕó

function temp_state=svm_test(test_data)
load('svmStruct0_1.mat')
load('svmStruct0_5.mat')
load('svmStruct2_3.mat')
test_data_mean=mean(test_data);
[x_tezheng,~]=aTeZhengtiqu3(test_data);
[~,n]=size(test_data_mean);
temp_state=[];
for i=1:n
    if test_data_mean(i)<32000
        aspecies =svmclassify(svmStruct0_1,x_tezheng(i,:),'Showplot',true);
        temp_state(i)=aspecies;
    else
        bspecies =svmclassify(svmStruct0_5,x_tezheng(i,:),'Showplot',true);
        if bspecies==5
            cspecies =svmclassify(svmStruct2_3,x_tezheng(i,:),'Showplot',true);
            temp_state(i)=cspecies;
        end
    end

end