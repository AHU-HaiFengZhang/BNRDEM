clear
clc

%��������
N=20;%�ڵ��� 
M=10;%������ 
n=2;%һ�³�ͼ����
k=3;%ÿ��ʱ��α���
T=20;%ʱ��γ���
MCMC_m=1000;%MCMC���г���
s=20;%ʱ����

%��������
id=1;   %������ ER:1 WS:2 BA:3
[S,w_true,N]=create_w(N,M,T,k,n,id,s);

%BNRDEM���
w=algorithm(S,n,N,MCMC_m);
[F1,accuracy]=resu_B(w_true,w,N);
