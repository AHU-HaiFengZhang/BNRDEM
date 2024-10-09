function [S,w_true]=ER(N,M,T,k,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%输入：
%N:节点数
%M:边数
%T:时间序列长度
%k:每个时间段边数
%n:一致超图阶数

%输出：
%S:时间序列
%w_ture:底层网络

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S=cell(1,T); %每个时间步的活跃节点
w=zeros(1,n);%生成网络
w_true=[];%底层网络


%生成ER网络
for i=1:M
    r=randperm(N);
    r=sort(r(1:n));    
    %如果生成的边已经存在则重新生成
    while ~isempty(find(sum(r==w,2)==n, 1))
       r=randperm(N);
       r=sort(r(1:n));
    end
    w=[w;r];
end
w(1,:)=[];

%从生成的边中每个时间步随机抽取k条边
for i=1:T
    r=randperm(M);
    x=w(r(1:k),:);
    S{i}=sort(reshape(x,[1,k*n]));
    w_true=[w_true;sum(N.^(0:n-1).*(x-1),2)+1];
end    
w_true=unique(w_true);

