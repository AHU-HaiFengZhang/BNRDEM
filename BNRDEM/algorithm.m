function w=algorithm(S,n,N,MCMC_m,P_a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���룺ʱ������S��һ�³�ͼ����n���ڵ���N��MCMC���г���MCMC_m
%������ع�����w

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[P,P_dl]=inniti_P(S,n,N);%��ʼ�����ʾ���


sample_n=100;%��ȡ�ع����������
sample_r=10;%����ԭ������������
sample_min=50;%ѡȡ������С���ع����������(sample_min<=sample_n)
iteration_j=10;%�����Ĵ���


T=length(S);%ʱ�䲽��
wall=cell(1,iteration_j);%��¼ÿ�ε����������ٵ�����
wall_t=zeros(size(P,1),sample_r);%��¼�ϴε����ع���������
wall_t_side=zeros(1,sample_r);%��¼�ϴε����ع�������������
wall_i=zeros(size(P,1),sample_n);%��¼��ǰ�����ع���������
wall_side=zeros(1,sample_n);%��¼��ǰ�����ع�����ı���
H_allconfig=cell(1,T);%�洢�ϴε���ÿ��ʱ��ι���


 for j=1:iteration_j    
     %��ÿ��ʱ��ν���MCMC����
     [H_config,H_config_dl,d]=MCMC(S,P,N,MCMC_m,H_allconfig,P_dl,n);
     H_allconfig=H_config;        
     %��ȡ�ع����������
     for i=1:sample_n
        %�ع������������ͱ���
        wall_i(:,i)=sample_nx(H_config,H_config_dl,d,P);
        wall_side(i)=length(find(wall_i(:,i)));
     end
     
     [~,d]=sort(wall_side);%�������������С��������
     %���ϴε����Ĳ��������滻��ǰ����������
     if j~=1
         wall_i(:,d(end-sample_r+1:end))=wall_t;
         wall_side(d(end-sample_r+1:end))=wall_t_side;
         [~,d]=sort(wall_side);
     end      
     wall{j}=P(wall_i(:,d(1))~=0,1);
     %�ж���ֹ����
     if j>=2&&length(wall{j})==length(wall{j-1})&&sum(wall{j}-wall{j-1})==0
         break;   
     end
     %��¼�ϴε����ع���������
     wall_t(:,1:sample_r)=wall_i(:,d(1:sample_r));
     wall_t_side(1:sample_r)=wall_side(d(1:sample_r));
     %ȡǰsample_min��������С��������¸��ʾ���
     w_minsum=sum(wall_side(d(1:sample_min)));     
     P(:,2)=(1-P_a)*P(:,2)+P_a*sum(wall_i(:,d(1:sample_min)),2)/w_minsum;
 end
 w=wall{j};
 