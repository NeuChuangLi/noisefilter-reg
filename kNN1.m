function [Xknn,Yknn] = kNN1(X,Y,k,datapoint)

m1=(X-datapoint).^2;
v1=sum(m1,2);
[~,v2]=sort(v1);
id=v2(2:1:k+1);
Xknn=X(id,:);
Yknn=Y(id,:);
end
