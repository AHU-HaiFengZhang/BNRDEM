function [H_config,H_config_dl,d]=MCMC(S,P,N,MCMC_m,H_allconfig,P_dl,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���룺
%S:ʱ������
%P:���ʾ���
%N:�ڵ����
%MCMC_m���������г���
%H_allconfig:�ϴε���ÿ��ʱ��ι���
%P_dl:ÿ��ʱ������бߵ�λ��
%n:һ�³�ͼ����
%���:
%H_config��ÿ��ʱ��ι���
%H_config_dl:ÿ��ʱ��αߵ�λ��
%d��ʱ��γ���˳��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T=length(S);%ʱ�䲽��
H_config=cell(1,T);%�洢ÿ��ʱ��ι���
H_config_dl=cell(1,T);%�洢ÿ��ʱ��αߵ�λ��
H_config_S=zeros(1,T);%�洢ÿ��ʱ��εĹ��͸��ʵ���
sample=cell(1,MCMC_m);%�洢��������



%��ÿ��ʱ��ι��ͽ��в��������ÿ�����͸��ʴ洢��H_config
for i=1:T
    MCMC_n=[];%����������ѡ���n����m�����������
    L=length(S{i});%ʱ���i��Ծ�ڵ���
    
    %ʱ��������ʼ����
    [sample{1},x1]=star_x(P,P_dl{i},S{i},N,n);  
    
    %��ȡMCMC_m����������
    for j=2:MCMC_m
        [x1,sample{j},trans]=sfor_s(L/n,x1,sample{j-1},P,P_dl{i},N,n);
        if isempty(MCMC_n)&&trans==1
            MCMC_n=j;
        end
    end
    if isempty(MCMC_n)
        MCMC_n=MCMC_m;
        x1=reshape(S{i},L/n,n);
        sample{MCMC_m}=sum(N.^(0:n-1).*(x1-1),2)+1;
    end
    
    %ȡ��sample_n������sample_m������������Ȼ����ÿ�ֹ��͵ĸ���
    H_sample=sort(cell2mat(sample(MCMC_n:MCMC_m)))';
    H_sample=[H_sample;H_allconfig{i}];
    H_config{i}=unique(H_sample,'rows');%ʱ���i��ÿ�ֹ���
    x=H_config{i}';
    y=x(:)';
    dl=find(P_dl{i}(:,1)==y);
    if size(dl,1)==1
        dl=dl';
    end
    dl=dl'-(0:length(y)-1)*size(P_dl{i},1);
    dl=P_dl{i}(dl,2);
    H_config_dl{i}=dl;
    HS=prod(reshape(P(dl,2),size(x)))';%ʱ���iÿ�ֹ��͵ĸ���
    HS=HS/sum(HS);
    H_config_S(i)=sum(-HS.*log2(HS+10^-100));%����
end
[~,d]=sort(H_config_S);%���صĴ�С����ʱ���
end

function [sample,x1]=star_x(P,P_dli,S_i,N,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ʱ��������ʼ����
%���룺��������P,λ��P_dli,ʱ������S_i
%�ڵ�N,����n
%�������ʼ����sample���±�x1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,d]=max(P(P_dli(:,2),2));
side_p=P(P_dli(d,2),3:end);
for j=1:n
    d=find(S_i==side_p(j));
    S_i(d(1))=[];
end

while ~isempty(S_i)
    Hc_a=S_i(allside(n,length(S_i)));
    Hc_ad=sum(N.^(0:n-1).*(Hc_a-1),2)+1;
    Hc_adp=[];
    
    for j=1:length(Hc_ad)
        aa=find(P(:,1)==Hc_ad(j));
        if ~isempty(aa)
            Hc_adp=[Hc_adp;P(aa,2)];
        else
            Hc_adp=[Hc_adp;0];
        end
    end
    [~,d]=max(Hc_adp);
    side_p=[side_p;Hc_a(d,:)];
    for j=1:n
        dd=find(S_i==Hc_a(d,j));
        S_i(dd(1))=[];
    end
end
sample=sum(N.^(0:n-1).*(side_p-1),2)+1;
x1=side_p;
end

function [x2,sample_f,trans]=sfor_s(k,x1,sample_o,P,P_dli,N,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�����¹���
%���룺���ͱ���k,ԭ����x1,�±�sample_o,��������P
%λ��P_dli,�ڵ���N������n
%������¹���x2���±�sample_f,�Ƿ�ת��trans

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

side=fix(rand()*k+1);%sideΪҪת�ƵĹ��͸ı�ı���
if side~=1
    %���ϸ����������ѡ��side���������д���
    d=randperm(length(sample_o));
    side_p=x1(d(1:side),:);%ҪĨȥ������Ϣ�ı�
    side_p=sort(side_p(reshape(randperm(side*n),side,n)),2);
    x2=x1;
    x2(d(1:side),:)=side_p;
    %ת�������±�
    x2_id=sum(N.^(0:n-1).*(x2-1),2)+1;
    [sample_f,x2,trans]=transfer(sample_o,x2_id,x1,x2,P,k,P_dli);
else
    %side���Ϊ1˵�����ı乹��
    sample_f=sample_o;
    x2=x1;
    trans=0;
end
end
