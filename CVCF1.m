function [noiseindex] = CVCF1(row,X,Y,numofsubsets)

X_loop=X;
Y_loop=Y;
flagmatrix=zeros(row,numofsubsets);
nos=floor(row/numofsubsets);
for i=1:1:numofsubsets
    front=(i-1)*nos+1;
    back=i*nos;
    X_loop(front:1:back,:)=[];
    Y_loop(front:1:back)=[];
    Modelcart=fitrtree(X_loop,Y_loop,'MinLeafSize',4);
    flagmatrix(:,i)=Modelcart.predict(X);
    X_loop=X;
    Y_loop=Y;
end

biasmatrix=abs(flagmatrix-Y);
onezeromatrix=zeros(row,numofsubsets);

for i=1:1:row
    for j=1:1:numofsubsets
        if biasmatrix(i,j)>=0.1
            onezeromatrix(i,j)=1;
        end
    end
end
vect=sum(onezeromatrix,2);
noiseindex=find(vect==numofsubsets);

end

