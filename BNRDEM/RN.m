function [S,w_true]=RN(N,M,T,k,n)
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

m=M/N;
S=cell(1,T); %ÿ��ʱ�䲽�Ļ�Ծ�ڵ�
w=zeros(1,n);%��������
w_true=[];%�ײ�����
w_degrees=zeros(N,1);


%����ER����
for i=1:m*20
    r=randperm(20);
    r=sort(r(1:n));    
    %������ɵı��Ѿ���������������
    while ~isempty(find(sum(r==w,2)==n, 1))
       r=randperm(20);
       r=sort(r(1:n));
    end
    w=[w;r];
    w_degrees(r,1)=w_degrees(r,1)+1;
end
w(1,:)=[];


%����RN����
for i=21:N
    for z=1:m
        r=[i];
        for j=1:n-1
            x=randsrc(1,1,[1:N;(w_degrees/sum(w_degrees))']);
            while ~isempty(find(sum(r==x), 1))
                x=randsrc(1,1,[1:N;(w_degrees/sum(w_degrees))']);
            end
            r=[r,x];
        end
        r=sort(r(1:n));
        w=[w;r];
        w_degrees(r,1)=w_degrees(r,1)+1;
    end
end

%�����ɵı���ÿ��ʱ�䲽�����ȡk����
for i=1:T
    r=randperm(M);
    x=w(r(1:k),:);
    S{i}=sort(reshape(x,[1,k*n]));
    w_true=[w_true;sum(N.^(0:n-1).*(x-1),2)+1];
end    
w_true=unique(w_true);

