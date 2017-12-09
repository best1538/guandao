%现在存在问题敲刨无振动时和有振动时不能拟合。
%现在有这种办法解决，一是做好端点检测用两个svm直接分类机械还是人工，2是用BP，做端点检测后用BP减小误报率还有进行分类。

clc
clear
% number=1000;
% dot_num=500;
% %
% %敲击信号数据
% load('I:\data\20170730100857.mat'); qiao3_1=data_c1(372,18*dot_num:end);
% load('I:\data\20170730101109.mat'); qiao3_2=data_c1(372,:);
% qiao3=[qiao3_1,qiao3_2];
% 
% load('I:\data\20170730102204.mat'); qiao4_1=data_c1(483,:);
% load('I:\data\20170730102415.mat'); qiao4_2=data_c1(483,:);
% load('I:\data\20170730102626.mat'); qiao4_3=data_c1(483,1:50*dot_num);
% qiao4=[qiao4_1,qiao4_2,qiao4_3];
% 
% load('I:\data\20170730104144.mat'); qiao5_1=data_c1(615:616,40*dot_num:end);
% load('I:\data\20170730104355.mat'); qiao5_2=data_c1(615:616,1:30*dot_num);
% qiao5=shape([qiao5_1,qiao5_2]);
% 
% load('I:\data\20170730105028.mat'); qiao6_1=data_c1(777:789,:);
% load('I:\data\20170730105239.mat'); qiao6_2=data_c1(777:789,:);
% qiao6_1=shape(qiao6_1);
% qiao6_2=shape(qiao6_2);
% 
% load('I:\data\20170730111008.mat'); qiao12_1=data_c1(1477,:);
% qiao12_2=data_c1(1484,:);            qiao12=[qiao12_1,qiao12_2];
% qiao_train=[qiao3,qiao4,qiao5,qiao6_1,qiao6_2,qiao12];
% qiao_test=qiao6_2;
% save('qiao_train.mat','qiao_train')
% %
% %刨信号数据
% %%
% %刨信号数据
% load('I:\data\20170730101532.mat'); pao3_1=data_c1(371:374,80*dot_num:end);
% load('I:\data\20170730101742.mat'); pao3_2=data_c1(371:374,1:30*dot_num);
% pao3=shape([pao3_1,pao3_2]);
% 
% load('I:\data\20170730103048.mat'); pao4_1=data_c1(472:474,:);
% load('I:\data\20170730103259.mat'); pao4_2=data_c1(472:474,:);
% pao4=shape([pao4_1,pao4_2]);
% 
% load('I:\data\20170730104606.mat'); 
% pao5=data_c1(615:617,:);
% pao5=shape(pao5);
% 
% load('I:\data\20170730105701.mat'); pao6_1=data_c1(787:789,:);
% load('I:\data\20170730105913.mat'); pao6_2=data_c1(787:789,1:30*dot_num);
% pao6=[pao6_1,pao6_2];
% pao6=shape(pao6);
% pao_train=[pao3,pao4,pao5,pao6];
% save('pao_train.mat','pao_train')
% %
% %挖掘
% load('I:\data\20170802123044.mat'); wajue7_5_1=data_c1(936:938,:);
% load('I:\data\20170802123255.mat'); wajue7_5_2=data_c1(936:938,:);
% load('I:\data\20170802123506.mat'); wajue7_5_3=data_c1(936:938,:);
% load('I:\data\20170802123717.mat'); wajue7_5_4=data_c1(936:938,1:50*dot_num);
% wajue7_5=[wajue7_5_1,wajue7_5_2,wajue7_5_3,wajue7_5_4];
% wajue7_5=shape(wajue7_5);
% 
% 
% load('I:\data\20170802124139.mat'); wajue7_10_1=data_c1(937:938,:);
% load('I:\data\20170802124350.mat'); wajue7_10_2=data_c1(937:938,:);
% load('I:\data\20170802124601.mat'); wajue7_10_3=data_c1(937:938,:);
% load('I:\data\20170802124812.mat'); wajue7_10_4=data_c1(937:938,1:50*dot_num);
% wajue7_10=[wajue7_10_1,wajue7_10_2,wajue7_10_3,wajue7_10_4];
% wajue7_10=shape(wajue7_10);
% 
% load('I:\data\20170802125234.mat'); wajue7_15_1=data_c1(936:939,:);
% load('I:\data\20170802125445.mat'); wajue7_15_2=data_c1(936:939,:);
% load('I:\data\20170802125656.mat'); wajue7_15_3=data_c1(936:939,:);
% load('I:\data\20170802125907.mat'); wajue7_15_4=data_c1(936:939,:);
% wuajue7_15=[wajue7_15_1,wajue7_15_2,wajue7_15_3,wajue7_15_4];
% wuajue7_15=shape(wuajue7_15);
% 
% load('I:\data\20170802130118.mat'); wajue7_20_1=data_c1(937:938,:);
% load('I:\data\20170802130330.mat'); wajue7_20_2=data_c1(937:938,:);
% load('I:\data\20170802130541.mat'); wajue7_20_3=data_c1(937:938,:);
% load('I:\data\20170802130752.mat'); wajue7_20_4=data_c1(937:938,:);
% wuajue7_20=[wajue7_20_1,wajue7_20_2,wajue7_20_3,wajue7_20_4];
% wuajue7_20=shape(wuajue7_20);
% wuajue7=[wajue7_5,wajue7_10,wuajue7_15,wuajue7_20];
% 
% 
% load('I:\data\20170802152420.mat'); wuajue11_5_1=data_c1(1380:1383,:);
% load('I:\data\20170802152631.mat'); wuajue11_5_2=data_c1(1380:1383,:);
% load('I:\data\20170802152842.mat'); wuajue11_5_3=data_c1(1380:1383,:);
% wuajue11_5=shape([wuajue11_5_1,wuajue11_5_2,wuajue11_5_3]);
% 
% load('I:\data\20170802151325.mat'); wuajue11_10_1=data_c1(1380:1382,:);
% load('I:\data\20170802151536.mat'); wuajue11_10_2=data_c1(1380:1382,:);
% load('I:\data\20170802151747.mat'); wuajue11_10_3=data_c1(1380:1382,:);
% wuajue11_10=shape([wuajue11_10_1,wuajue11_10_2,wuajue11_10_3]);
% 
% load('I:\data\20170802150441.mat'); wuajue11_15_1=data_c1(1380:1383,:);
% load('I:\data\20170802150651.mat'); wuajue11_15_2=data_c1(1380:1383,:);
% load('I:\data\20170802150903.mat'); wuajue11_15_3=data_c1(1380:1383,:);
% wuajue11_15=shape([wuajue11_15_1,wuajue11_15_2,wuajue11_15_3]);
% 
% load('I:\data\20170802145556.mat'); wuajue11_20_1=data_c1(1381:1382,:);
% load('I:\data\20170802145807.mat'); wuajue11_20_2=data_c1(1381:1382,:);
% wuajue11_20=shape([wuajue11_20_1,wuajue11_20_2]);
% 
% wuajue11=[wuajue11_5,wuajue11_10,wuajue11_15,wuajue11_20];
% 
% 
% load('I:\data\20170802164703.mat'); wuajue16_5_1=data_c1(1972:1975,:);
% load('I:\data\20170802164914.mat'); wuajue16_5_2=data_c1(1972:1975,:);
% load('I:\data\20170802165126.mat'); wuajue16_5_3=data_c1(1972:1975,:);
% wuajue16_5=[wuajue16_5_1,wuajue16_5_2,wuajue16_5_3];
% wuajue16_5=shape(wuajue16_5);
% 
% load('I:\data\20170802163819.mat'); wuajue16_10_1=data_c1(1970:1971,:);
% load('I:\data\20170802164030.mat'); wuajue16_10_2=data_c1(1970:1971,:);
% load('I:\data\20170802164241.mat'); wuajue16_10_3=data_c1(1970:1971,:);
% wuajue16_10=[wuajue16_10_1,wuajue16_10_2,wuajue16_10_3];
% wuajue16_10=shape(wuajue16_10);
% 
% load('I:\data\20170802162724.mat'); wuajue16_15_1=data_c1(1970:1971,:);
% load('I:\data\20170802162935.mat'); wuajue16_15_2=data_c1(1972:1973,:);
% load('I:\data\20170802163146.mat'); wuajue16_15_3=data_c1(1973:1974,:);
% wuajue16_15=[wuajue16_15_1,wuajue16_15_2,wuajue16_15_3];
% wuajue16_15=shape(wuajue16_15);
% 
% load('I:\data\20170802161839.mat'); wuajue16_20_1=data_c1(1970:1971,:);
% load('I:\data\20170802162050.mat'); wuajue16_20_2=data_c1(1970:1971,:);
% load('I:\data\20170802162302.mat'); wuajue16_20_3=data_c1(1970:1971,:);
% wuajue16_20=shape([wuajue16_20_1,wuajue16_20_2,wuajue16_20_3]);
% 
% wuajue16=[wuajue16_5,wuajue16_10,wuajue16_15,wuajue16_20];
% wuajue_train=[wuajue7,wuajue11,wuajue16];
% save('wuajue_train.mat','wuajue_train')
% wuajue_test=wuajue16_10_3;
% 
% 
% load('I:\data\20170730103048.mat'); no_1_1=shape(data_c1(937:939,:));  no_1_2=data_c1(372,:);
% load('I:\data\20170730103933.mat'); no_2_1=shape(data_c1(900:903,:));  no_2_2=shape(data_c1(372:374,:));  no_2_3=shape(data_c1(1381:1384,:));
% load('I:\data\20170730101320.mat'); no_3_1=shape(data_c1(472:474,:));  no_3_2=shape(data_c1(925:927,:));  no_3_3=shape(data_c1(1379:1381,:)); 
% load('I:\data\20170730101742.mat'); no_4_1=shape(data_c1(925:927,:)); no_4_2=shape(data_c1(614:616,:)); no_4_3=shape(data_c1(472:475,:));
% load('I:\data\20170730104144.mat'); no_5_1=shape(data_c1(925:928,:)); no_5_2=shape(data_c1(1379:1382,:)); no_5_3=shape(data_c1(371:373,:));no_5_4=shape(data_c1(471:474,:));
% load('I:\data\20170730105450.mat'); no_6_1=shape(data_c1(371:373,:));  no_6_2=shape(data_c1(925:928,:));
% 
% load('I:\data\20170802123506.mat'); no_7_1=shape(data_c1(371:374,:)); no_7_2=shape(data_c1(371:374,:)); no_7_3=shape(data_c1(615:618,:)); 
% load('I:\data\20170802123928.mat'); no_8_1=shape(data_c1(472:474,:));  no_8_2=shape(data_c1(1382:1384,:));  no_8_3=shape(data_c1(1973:1975,:));
% load('I:\data\20170802125656.mat'); no_9_1=shape(data_c1(614:616,:)); no_9_2=shape(data_c1(1381:1384,:)); no_9_3=shape(data_c1(1973:1975,:));
% load('I:\data\20170802145807.mat');  no_10_1=shape(data_c1(472:474,:)); no_10_2=shape(data_c1(371:374,:));
% load('I:\data\20170802151536.mat');  no_11_1=shape(data_c1(925:927,:)); no_11_2=shape(data_c1(371:373,:)); no_11_3=shape(data_c1(471:473,:));
% load('I:\data\20170802162935.mat');  no_12_1=shape(data_c1(925:927,:)); no_12_2=shape(data_c1(371:373,:));no_12_3=shape(data_c1(471:473,:));no_12_4=shape(data_c1(1371:1373,:));
% no_1=[no_1_1,no_1_2,no_2_1,no_2_2,no_2_3,no_3_1,no_3_2,no_3_3,no_4_1,no_4_2,no_4_3,no_5_1,no_5_2,no_5_3,no_6_1,no_6_2];
% no_2=[no_7_1,no_7_2,no_7_3,no_8_1,no_8_2,no_8_3,no_9_1,no_9_2,no_9_3,no_10_1,no_10_2,no_11_1,no_11_2,no_11_3,no_12_1,no_12_2,no_12_3];
% save('no_1.mat','no_1');
% save('no_2.mat','no_2');
load('no_1.mat','no_1');
% load('no_2.mat','no_2');
load('qiao_train.mat','qiao_train');
load('pao_train.mat','pao_train');
% load('wuajue_train.mat','wuajue_train');
load('no_train.mat','no_train');
% wuajue_train=wuajue_train(1,1:2:end);%这里只要挖掘一般的数据
[no_1,r1]=aTeZhengtiqu3(no_1(1,1:3000000));%人工非振动数据
% [no_2,j1]=aTeZhengtiqu3(no_2);%机械非振动数据
[qiao_train,x1]=aTeZhengtiqu3(qiao_train);
[pao_train,y1]=aTeZhengtiqu3(pao_train);  
% [wuajue_train,w1]=aTeZhengtiqu3(wuajue_train);
%
%先用svm二分类方法把侵入类型分为入侵和无入侵两种
%若是入侵则分类标签是8，无入侵标签是7

% wuajue_train_label=ones(1,w1);%挖掘的的标签
% no_ren_label=zeros(1,j1);%敲刨的标签
% train_label=[no_ren_label,wuajue_train_label]';
% train=cat(1,no_2,wuajue_train);
% svmStruct0_1 =svmtrain(train,train_label,'Showplot',true);
% save('svmStruct0_1','svmStruct0_1') 

%先用svm二分类方法把侵入类型分为挖掘和镐刨两种
%若是机械挖掘则分类标签是1，非挖掘标签是0

train_qiao_or_pao=cat(1,qiao_train,pao_train);
no_ren_label=zeros(1,r1);%挖掘的的标签
train_label_qiao_or_pao=repmat(5,1,x1+y1);%敲刨的标签
train_label=[no_ren_label,train_label_qiao_or_pao]';
train=cat(1,no_1,train_qiao_or_pao);
svmStruct0_5 =svmtrain(train,train_label,'Showplot',true);
save('svmStruct0_5.mat','svmStruct0_5') 
% %
% %%若标签是1则显示为机械挖掘，若是0再对其进行二分类，敲击信号的标签是2，刨信号的标签是3
% train_label_qiao=repmat(2,1,x1);%敲的的标签
% train_label_pao=repmat(3,1,y1);%刨的标签
% train_label3=[train_label_qiao,train_label_pao]';
% train3=cat(1,qiao_train,pao_train);
% svmStruct2_3 =svmtrain(train3,train_label3,'Showplot',true);
% save('svmStruct2_3.mat','svmStruct2_3') 
