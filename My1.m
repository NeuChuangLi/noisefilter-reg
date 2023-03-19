function [majorityindex] = My1(row,X,Y,belta,threshold,kofknn,kofbagging)

filterindex_2=zeros(row,1);

Feature_2=X;
Label_2=Y;

detecttotal_2=zeros(20,1);

accutotal_2=zeros(20,1);

noisecell_2=cell(20,1);

avedis=zeros(row,1);
for i=1:1:row
    distance=zeros(row,1);
    for j=1:1:row
        distance(j)=sqrt(sum((X(i,:)-X(j,:)).^2));
    end
    distance=sort(distance);
    avedis(i)=sum(distance(2:1:(kofknn+1)))/kofknn;
end
maxave=max(avedis);
minave=min(avedis);
avedis=(avedis-minave)/(maxave-minave);

for i=1:1:20
    lastfilterindex_2=filterindex_2;
    filterindex_2=zeros(row,1);    
    
    rng(100+i);
    [~,idmatrix]=bootstrp(kofbagging,[],Feature_2);  %idmatrix是一个row行，numofbootstrap列的矩阵，每一列是一次bootstrap采样的下标
    Bagindex=zeros(row,kofbagging);
    accbag=zeros(kofbagging,1);
    for j=1:1:kofbagging
        inputmatrix=Feature_2(idmatrix(:,j),:);
        outputvector=Label_2(idmatrix(:,j));
        Modelcart=fitrtree(inputmatrix,outputvector,'MinLeafSize',4);
        ypredict=Modelcart.predict(X);
              
        SSR=sum((ypredict-mean(Y)).^2);
        SST=sum((Y-mean(Y)).^2);
        Rsquire=SSR/SST;
        if Rsquire>1
            Rsquire=0.3;
        end  
        if Rsquire<0.3
            Rsquire=0.3;
        end         

        adaptvalue=0.12*avedis/Rsquire+0.1;

        biasplus=threshold*adaptvalue;       
        bias=abs(ypredict-Y); 
        mmind=find(bias>=biasplus);   
        Bagindex(mmind,j)=1;  
        
        ypredict(mmind,:)=[];
        ylabel=Y;
        ylabel(mmind,:)=[];
        numimd=size(ylabel,1);
        accbag(j)=sum(abs(ylabel-ypredict))/numimd;
    end    
    addindex=sum(Bagindex,2);
    noiseindex=find(addindex>=ceil(kofbagging/2));
    
    noisecell_2(i)={noiseindex};
    detectnoisenum=size(noiseindex,1);
    detecttotal_2(i)=detectnoisenum;
             
    for j=1:1:detectnoisenum
        filterindex_2(noiseindex(j))=1;
    end
    if sum(filterindex_2-lastfilterindex_2)==0
        stopepoch_2=i-1;
        break;
    else
        if i==20
            stopepoch_2=20;
        end
        Feature_2=X;
        Label_2=Y;
        Feature_2(noiseindex,:)=[];
        Label_2(noiseindex,:)=[];
    end
    accutotal_2(i)=mean(accbag);
end


noisecell=cell(1,1);
accutotal=accutotal_2(1:1:stopepoch_2);
noisecell(1)={noisecell_2(1:1:stopepoch_2)};


accu_2=1./accutotal;
accu_2=accu_2/sum(accu_2);
matrix_2=zeros(row,stopepoch_2);
for i=1:1:stopepoch_2
    matrix_2(noisecell{1}{i},i)=accu_2(i);
end
jiaquanvec_2=sum(matrix_2,2);
id2=find(jiaquanvec_2>belta);
majorityindex=id2;

end
