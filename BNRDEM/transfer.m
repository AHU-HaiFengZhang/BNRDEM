function [x1_id,x1,trans]=transfer(x1_id,x2_id,x1,x2,P,k,P_dl_i)
%����:
%x1_id��ԭ���Ĺ����±� 
%x1��ԭ���Ĺ��� 
%x2_id��ת����Ĺ����±�
%x2��ת����Ĺ���
%k:ÿ��ʱ��γ�����
%P_dl_i:��iʱ��ι��͵�λ��


%�����
%x_id:��Ϊ�����Ĺ����±�
%x1:��Ϊ�����Ĺ���
%trans:�Ƿ�ת�Ʊ�־

trans=0;
dl=find(P_dl_i(:,1)==x2_id');
if size(dl,1)==1
    dl=dl';
end
if length(dl)==k        
    dl=dl'-(0:length(dl)-1)*size(P_dl_i,1);
    dl=P_dl_i(dl,2);
    P2=prod(P(dl,2));%ת�ƹ��͸���
    if isempty(find(sum(x2_id==x2_id')>=2, 1))%�ж��Ƿ����ر�
        trans=1;
        dl=find(P_dl_i(:,1)==x1_id');
        if size(dl,1)==1
            dl=dl';
        end
        if length(dl)==k
            dl=dl'-(0:length(dl)-1)*size(P_dl_i,1);
            dl=P_dl_i(dl,2);
            P1=prod(P(dl,2));%ԭ���͸���
            alpha=min(1,P2/P1);%���ֲܷ�
            u=rand();
            if u<=alpha
                x1_id=x2_id;
                x1=x2;               
            end
        else
            x1_id=x2_id;
            x1=x2;
        end
    end
end
