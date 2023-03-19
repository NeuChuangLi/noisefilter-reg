function [noiseindex] = DiscENN1(row,X,Y,k,entropyb)

%先找到最佳的分割区间
bestentropy=100000;
for i=2:1:entropyb
    intevec=cell(i,1);
    interval=1/i;
    for j=1:1:row
        for k=1:1:i
            if Y(j)>=(0+(k-1)*interval) && Y(j)<=(0+k*interval)
                intevec(k)={[intevec{k};j]};
            end
        end
    end
    %计算熵
    sumentropy=0;
    for m=1:1:i
        sumentropy=sumentropy+size(intevec{m},1)/row*log(size(intevec{m},1)/row);
    end
    sumentropy=-sumentropy;
    if sumentropy<bestentropy
        bestentropy=sumentropy;
        bin=i;
        Finavec=intevec;
    end
end

%开始执行原始的ENN
Ydiscrete=zeros(row,1);
for i=1:1:row
    for j=1:1:bin
        if ismember(i,Finavec{j})
            Ydiscrete(i)=j;
        end
    end
end

X_loop=X;
Y_loop=Ydiscrete;
noiseindex=0;
flag=1;

for i=1:1:row
    [~,Yknn]=kNN1(X_loop,Y_loop,k,X(i,:));
    table1=tabulate(Yknn);
    Ypred=table1(end,1);
    if Ydiscrete(i)~=Ypred
        noiseindex(flag,1)=i;
        flag=flag+1;
        X_loop(i,:)=X_loop(i,:)+1000000;
        Y_loop(i)=0;
    end
end

end

