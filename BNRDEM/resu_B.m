function [F1,accuracy]=resu_B(w_true,w,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ָ��
%���룺��ʵ����w_true���ع�����w���ڵ���N
%�����F1��accuracy

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=length(w_true);%��ʵ�ı���
n=length(w);%Ԥ�����
a=length(unique([w_true;w]));%���ظ�����
fp=a-m;%��Ԥ��ı�
tp=n-fp;%Ԥ��Եı�
recall=tp/m;  %�ٻ���
percision=tp/(tp+fp); %����
F1=2/(1/recall+1/percision);
accuracy=1-(2*a-n-m)/N;