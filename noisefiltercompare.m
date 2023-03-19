function [RMSEall] = noisefiltercompare(seed,percent,inputmatrix)

warning('off');

[row,X,Y] = normalizaion(inputmatrix);

Y_clean=Y;

nos=floor(row/5);
RMSElr=zeros(25,7);
RMSEcart=zeros(25,7);
RMSEelm=zeros(25,7);
for i=1:1:5
    if percent~=0
        rng(seed+i);
        randind=randperm(row)';
        numofnoise=floor(row*percent);
        rng(seed);
        for s=1:1:numofnoise
            Y(randind(s))=sqrt(0.5)*randn;
        end
    end
    rng(seed+100+i);
    index=randperm(row)';
    Xtrain=X(index,:);
    Ytrain=Y(index);
    Ytrain_clean=Y_clean(index);
    for j=1:1:5
        Xjtrain=Xtrain;
        Yjtrain=Ytrain;
        front=(j-1)*nos+1;
        back=j*nos;
        if j==5
            Xjtrain(front:1:row,:)=[];
            Yjtrain(front:1:row)=[];
        else
            Xjtrain(front:1:back,:)=[];
            Yjtrain(front:1:back)=[];
        end
        rowinj=size(Xjtrain,1);
        Xjtraincell=cell(7,1);
        Yjtraincell=cell(7,1);
        for kk=1:1:7
            Xjtraincell(kk)={Xjtrain};
            Yjtraincell(kk)={Yjtrain};
        end
        index_my=My1(rowinj,Xjtrain,Yjtrain,0.5,0.7,5,9);      %1
        index_ENN=ENN1(rowinj,Xjtrain,Yjtrain,9,1);                                    %2
        index_CVCF=My2(rowinj,Xjtrain,Yjtrain,0.5,1,9,9);                          %3
        index_BF=DiscENN1(rowinj,Xjtrain,Yjtrain,9,10);                                %4
        index_Allknn=DROP3RT1(rowinj,Xjtrain,Yjtrain,9,1,0.5);                         %5
        index_EF=CVCF1(rowinj,Xjtrain,Yjtrain,3);                                      %6
        index_IPF=IPF1(rowinj,Xjtrain,Yjtrain,10);                                     %7
        if index_my~=0
            Xjtraincell{1}(index_my,:)=[];
            Yjtraincell{1}(index_my)=[];
        end
        if index_ENN~=0
            Xjtraincell{2}(index_ENN,:)=[];
            Yjtraincell{2}(index_ENN)=[];
        end
        if index_CVCF~=0
            Xjtraincell{3}(index_CVCF,:)=[];
            Yjtraincell{3}(index_CVCF)=[];
        end        
        if index_BF~=0
            Xjtraincell{4}(index_BF,:)=[];
            Yjtraincell{4}(index_BF)=[];
        end         
        if index_Allknn~=0
            Xjtraincell{5}(index_Allknn,:)=[];
            Yjtraincell{5}(index_Allknn)=[];
        end        
        if index_EF~=0
            Xjtraincell{6}(index_EF,:)=[];
            Yjtraincell{6}(index_EF)=[];
        end    
        if index_IPF~=0
            Xjtraincell{7}(index_IPF,:)=[];
            Yjtraincell{7}(index_IPF)=[];
        end 
        for ll=1:1:7
            if j==5
                rng(1);
                Mdnet=feedforwardnet(15);
                Mdnet.trainParam.showWindow=false;
                rng(1)
                Mdnet1=train(Mdnet,Xjtraincell{ll}',Yjtraincell{ll}');
                Y_net=Mdnet1(Xtrain(front:1:row,:)');
                Y_elm=Y_net';
                RMSEelm((i-1)*5+j,ll)=sqrt(mean((Y_elm-Ytrain_clean(front:1:row)).^2));
                
                Y_lr=zeros(row-front+1,1);
                for pp=front:1:row
                    [~,Yknn] = kNN2(Xjtraincell{ll},Yjtraincell{ll},3,Xtrain(pp,:));
                    Y_lr(pp-front+1)=mean(Yknn);
                end

                RMSElr((i-1)*5+j,ll)=sqrt(mean((Y_lr-Ytrain_clean(front:1:row)).^2));
                                
                rng(1);
                tpT=templateTree('MinLeafSize',1);
                Mdlrrf=fitrensemble(Xjtraincell{ll},Yjtraincell{ll},'Learners',tpT,'Method','Bag','NumLearningCycles',50);
                Y_rf=Mdlrrf.predict(Xtrain(front:1:row,:));
                RMSEcart((i-1)*5+j,ll)=sqrt(mean((Y_rf-Ytrain_clean(front:1:row)).^2));
            else
                rng(1);
                Mdnet=feedforwardnet(15);
                Mdnet.trainParam.showWindow=false;
                rng(1);
                Mdnet1=train(Mdnet,Xjtraincell{ll}',Yjtraincell{ll}');
                Y_net=Mdnet1(Xtrain(front:1:back,:)');
                Y_elm=Y_net';  
                RMSEelm((i-1)*5+j,ll)=sqrt(mean((Y_elm-Ytrain_clean(front:1:back)).^2));             
                Y_lr=zeros(back-front+1,1);
                for pp=front:1:back
                    [~,Yknn] = kNN2(Xjtraincell{ll},Yjtraincell{ll},3,Xtrain(pp,:));
                    Y_lr(pp-front+1)=mean(Yknn);
                end    

                RMSElr((i-1)*5+j,ll)=sqrt(mean((Y_lr-Ytrain_clean(front:1:back)).^2)); 
                
                
                rng(1);
                tpT=templateTree('MinLeafSize',1);
                Mdlrrf=fitrensemble(Xjtraincell{ll},Yjtraincell{ll},'Learners',tpT,'Method','Bag','NumLearningCycles',50);
                Y_rf=Mdlrrf.predict(Xtrain(front:1:back,:));
                RMSEcart((i-1)*5+j,ll)=sqrt(mean((Y_rf-Ytrain_clean(front:1:back)).^2));
            end
        end   
    end
    seed=seed+1;
    Y=Y_clean;
end

RMSEall=zeros(3,7);
RMSEall(1,:)=mean(RMSElr);              
RMSEall(2,:)=mean(RMSEcart);            
RMSEall(3,:)=mean(RMSEelm);             

end

