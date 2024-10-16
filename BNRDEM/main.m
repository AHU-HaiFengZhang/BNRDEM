clear
clc

%参数设置
P_a=0.4;%概率矩阵更新参数(学习速率)
N=200;%节点数 
M=1000;%超边数 
n=2;%一致超图阶数
k=3;%每个时间段边数
T=2000;%时间段长度
MCMC_m=1000;%MCMC序列长度
s=20;%时间间隔

%生成网络
id=1;   %网络编号 ER:1 WS:2 BA:3
[S,w_true,N]=create_w(N,M,T,k,n,id,s);

%BNRDEM结果
w=algorithm(S,n,N,MCMC_m,P_a);
[F1,accuracy]=resu_B(w_true,w,N);
