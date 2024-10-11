function [S,w_true]=WS(N,M,T,k,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���룺
%N:�ڵ���
%M:����
%T:ʱ�����г���
%k:ÿ��ʱ��α���
%n:һ�³�ͼ����

%�����
%S:ʱ������
%w_ture:�ײ�����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p=0.5;
m=M/N;
S=cell(1,T); %ÿ��ʱ�䲽�Ļ�Ծ�ڵ�
w=zeros(1,n);%��������
w_true=[];%�ײ�����


%����WS����
for i=0:N-1
    for j=1:m
       w=[w;[i,mod(i+j,N)]];
       w=[w;[i,mod(N+i-j,N)]];
    end
end
w(1,:)=[];
w=w+1;
w=sort(w,2);
w=unique(w,'rows');


for i=1:M
    u=rand;
    if u>=p
        x=ceil(N*rand);
        while ~isempty(find(sum(w==sort([w(i,1),x]),2)==2, 1))||x==w(i,1)
            x=ceil(N*rand);
        end
        w(i,2)=x;
        w=sort(w,2);
    end
end
w=unique(w,'rows');

%�����ɵı���ÿ��ʱ�䲽�����ȡk����
for i=1:T
    r=randperm(M);
    x=w(r(1:k),:);
    S{i}=sort(reshape(x,[1,k*n]));
    w_true=[w_true;sum(N.^(0:n-1).*(x-1),2)+1];
end    
w_true=unique(w_true);

