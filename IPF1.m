function [totalindex] = IPF1(row,X,Y,seed)

X_loop=X;
Y_loop=Y;
oriindex=[1:1:row]';
noisecell=cell(1000,1);
flagvec=zeros(1000,1);

for i=1:1:10000
    looprow=size(X_loop,1);
    predictmatrix=zeros(looprow,5);
    nos=floor(looprow/5);
    rng(seed);
    index=randperm(looprow)';
    
    for j=1:1:5
        front=(j-1)*nos+1;
        back=j*nos;
        trainx=X_loop(index(front:1:back),:);
        trainy=Y_loop(index(front:1:back),:);
        Modelcart=fitrtree(trainx,trainy,'MinLeafSize',4);
        predictmatrix(:,j)=Modelcart.predict(X_loop);
    end
    
    biasmatrix=abs(predictmatrix-Y_loop);
    onezeromatrix=zeros(looprow,5);
    for k=1:1:looprow
        for l=1:1:5
            if biasmatrix(k,l)>=0.1
                onezeromatrix(k,l)=1;
            end
        end
    end
    vect=sum(onezeromatrix,2);
    noiseindex=find(vect>=3);
    noisecell(i)={oriindex(noiseindex)};
    
    oriindex(noiseindex)=[];
    X_loop(noiseindex,:)=[];
    Y_loop(noiseindex)=[];
    seed=seed+1;
    
    if size(X_loop,1)<5
        stopite=i;
        break;
    end
    
    dectnum=size(noiseindex,1);
    if dectnum<(0.01*row)
        flagvec(i)=1;
    end
    
    if i>=3 && flagvec(i)==1 && flagvec(i-1)==1 && flagvec(i-2)==1
        stopite=i;
        break;
    end
    
end

vectt=zeros(2,1);
for i=1:1:stopite
    vectt=[vectt;noisecell{i}];
end

totalindex=vectt(3:1:end);

if (row-size(totalindex,1))<=2
    totalindex=totalindex(1:1:end-2);
end

end
