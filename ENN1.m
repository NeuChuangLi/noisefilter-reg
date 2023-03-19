function [noiseindex] = ENN1(row,X,Y,k,alpha)

X_loop=X;
Y_loop=Y;
noiseindex=0;
flag=1;
% jilu=zeros(row,1);

for i=1:1:row
    [~,Yknn]=kNN1(X_loop,Y_loop,k,X(i,:));
    if abs(Y(i)-mean(Yknn))>(alpha*std(Yknn))
%         jilu(i)=alpha*std(Yknn);
        noiseindex(flag,1)=i;
        flag=flag+1;
        X_loop(i,:)=X_loop(i,:)+1000000;
        Y_loop(i)=Y_loop(i)+1000000;
    end
end

end

