function w_i=sample_nx(H_config,H_config_dl,d,P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���룺
%H_config��ÿ��ʱ��ι���
%config_dl:ÿ��ʱ��αߵ�λ��
%d��ʱ��γ���˳��
%P:���ʾ���

%�����
%w_i���ع�����������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P=P(:,2);%��ʼ����
w_i=zeros(length(P),1);%��¼ʱ���d��ѡ���͵�����
lamta=10^-10;%��Сֵ


for i=1:length(d)
    dl=reshape(H_config_dl{d(i)},size(H_config{d(i)}'));
    P_s=P(dl);%��ʼʱ��ѡ���й��͵ĸ���
    D_t=w_i(dl);%��tʱ����ѡ���͵ĸ���
    P_t=lamta.*P_s+(1-lamta).*D_t;
    %��tʱ�̺�ѡ���й��͵ĸ���
    P_t=max(prod(P_t,1),10^(-300));
    P_t=P_t/max(sum(P_t),10^(-300));
    %�����ʳ�ȡʱ��εĹ���
    if ~isempty(H_config{d(i)})
        x=randsrc(1,1,[1:size(H_config{d(i)},1);(P_t)]);
        dl=dl(:,x);
        w_i(dl)=w_i(dl)+1;
    end
end

w_i(w_i(:)~=0)=1;

end
    
    


