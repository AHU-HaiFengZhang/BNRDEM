function [S,w_true]=ER(N,M,T,k,n)
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

S=cell(1,T); %ÿ��ʱ�䲽�Ļ�Ծ�ڵ�
w=zeros(1,n);%��������
w_true=[];%�ײ�����


%����ER����
for i=1:M
    r=randperm(N);
    r=sort(r(1:n));    
    %������ɵı��Ѿ���������������
    while ~isempty(find(sum(r==w,2)==n, 1))
       r=randperm(N);
       r=sort(r(1:n));
    end
    w=[w;r];
end
w(1,:)=[];

%�����ɵı���ÿ��ʱ�䲽�����ȡk����
for i=1:T
    r=randperm(M);
    x=w(r(1:k),:);
    S{i}=sort(reshape(x,[1,k*n]));
    w_true=[w_true;sum(N.^(0:n-1).*(x-1),2)+1];
end    
w_true=unique(w_true);

