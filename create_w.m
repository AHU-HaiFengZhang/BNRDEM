function [S,w_true,N]=create_w(N,M,T,k,n,id,s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���ɸ��������ʱ������
%���룺�ڵ�N������M��ʱ��γ���T��ÿ��ʱ��α���k,����n
%�����ţ�id=
%id=1   ER����
%id=2   WS����
%id=3   BA����
%ʱ����s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch id
    case 1
        [S,w_true]=ER(N,M,T,k,n);
        
    case 2
        [S,w_true]=WS(N,M,T,k,n);
        
    case 3
        [S,w_true]=RN(N,M,T,k,n);
        
    case 4
        if n==2
            [S,k]=Village_2(s);
        else
            [S,k]=Village_3(s);
        end

        w_true=[];%�ײ�����
        T=length(k);
        N=max(S(:));
        SS=cell(1,T);
        for i=1:T
            x=S(1:k(i),:);
            x=unique(x,'rows');
            SS{i}=sort(reshape(x,[1,numel(x)]));
            w_true=[w_true;sum(N.^(0:n-1).*(x-1),2)+1];
            S(1:k(i),:)=[];
        end
        w_true=unique(w_true);
        S=SS;
        
        case 5
        if n==2
            [S,k]=InVS13_2(s);
        else
            [S,k]=InVS13_3(s);
        end
        
        T=length(k);
        w_true=[];%�ײ�����
        N=max(S(:));
        SS=cell(1,T);
        for i=1:T
            x=S(1:k(i),:);
            x=unique(x,'rows');
            SS{i}=sort(reshape(x,[1,numel(x)]));
            w_true=[w_true;sum(N.^(0:n-1).*(x-1),2)+1];
            S(1:k(i),:)=[];
        end
        w_true=unique(w_true);
        S=SS;
        
        case 6
        if n==2
            [S,k]=Hospital_2(s);
        else
            [S,k]=Hospital_3(s);
        end
        T=length(k);
        w_true=[];%�ײ�����
        N=max(S(:));
        SS=cell(1,T);
        for i=1:T
            x=S(1:k(i),:);
            x=unique(x,'rows');
            SS{i}=sort(reshape(x,[1,numel(x)]));
            w_true=[w_true;sum(N.^(0:n-1).*(x-1),2)+1];
            S(1:k(i),:)=[];
        end
        w_true=unique(w_true);
        S=SS;
        
        case 7
        if n==2
            [S,k]=InVS15_2(s);
        else
            [S,k]=InVS15_3(s);
        end

        T=length(k);
        w_true=[];%�ײ�����
        N=max(S(:));
        SS=cell(1,T);
        for i=1:T
            x=S(1:k(i),:);
            x=unique(x,'rows');
            SS{i}=sort(reshape(x,[1,numel(x)]));
            w_true=[w_true;sum(N.^(0:n-1).*(x-1),2)+1];
            S(1:k(i),:)=[];
        end
        w_true=unique(w_true);
        S=SS;
end
end











