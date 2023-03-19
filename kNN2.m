function [Xknn,Yknn] = kNN2(X,Y,k,datapoint)

m1=(X-datapoint).^2;
v1=sum(m1,2);
[~,v2]=sort(v1);
rr=size(v2,1);
if rr<k
    id=v2;
else
    id=v2(1:1:k);
end
Xknn=X(id,:);
Yknn=Y(id,:);
end

