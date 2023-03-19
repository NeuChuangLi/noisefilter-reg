function [KNNCELL,RFCELL,BPCELL] = Wilcox()

warning('off');

[KEEL_mortgage,KEEL_treasury,KEEL_wankara,KEEL_wizmir,KEEL_ele_2,KEEL_stock,KEEL_concrete,KEEL_compactiv,KEEL_machineCPU,UCI_day,UCI_RBDS,UCI_airquality,UCI_Processed_DJI,KEEL_mv,UCI_Facebook,KEEL_friedman,UCI_music,KEEL_autompg8,UCI_Steelindustry,KEEL_forestfires,KEEL_laser,UCI_gt1] = loaddata1;

matrixcell=cell(22,1);
matrixcell(1)={KEEL_mortgage};
matrixcell(2)={KEEL_treasury};
matrixcell(3)={KEEL_wankara};
matrixcell(4)={KEEL_wizmir};
matrixcell(5)={KEEL_ele_2};
matrixcell(6)={KEEL_stock};
matrixcell(7)={KEEL_concrete};
matrixcell(8)={KEEL_compactiv};
matrixcell(9)={KEEL_machineCPU};
matrixcell(10)={UCI_day};
matrixcell(11)={UCI_RBDS};
matrixcell(12)={UCI_airquality};
matrixcell(13)={UCI_Processed_DJI};
matrixcell(14)={KEEL_mv};
matrixcell(15)={UCI_Facebook};
matrixcell(16)={KEEL_friedman};
matrixcell(17)={UCI_music};
matrixcell(18)={KEEL_autompg8};
matrixcell(19)={UCI_Steelindustry};
matrixcell(20)={KEEL_forestfires};
matrixcell(21)={KEEL_laser};
matrixcell(22)={UCI_gt1};

LRCELL=cell(22,5);
RFCELL=cell(22,5);
ELMCELL=cell(22,5);
for o=1:1:22
    o
    [row,X,Y] = normalization(matrixcell{o});

    Y_clean=Y;

    nos=floor(row/5);
    for percent=1:1:5
        Y=Y_clean;
        seed=100*(percent+1);
        RMSElr=zeros(25,2);
        RMSEcart=zeros(25,2);
        RMSEelm=zeros(25,2);
        for i=1:1:5

            rng(seed+i);
            randind=randperm(row)';
            if percent==1
                perct=0.1;
            end
            if percent==2
                perct=0.2;
            end
            if percent==3
                perct=0.3;
            end
            if percent==4
                perct=0.4;
            end
            if percent==5
                perct=0.5;
            end
            numofnoise=floor(row*perct);
            rng(seed);

            for s=1:1:numofnoise
                Y(randind(s))=sqrt(0.5)*randn;
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
                Xjtraincell={Xjtrain};
                Yjtraincell={Yjtrain};
                index_my=MymethodBaggingtest(rowinj,Xjtrain,Yjtrain,0.5,0.7,5,9);       %1
                if index_my~=0
                    Xjtraincell{1}(index_my,:)=[];
                    Yjtraincell{1}(index_my)=[];
                end                                
                if j==5
%                     Y_elm=elmelm(Xjtraincell{1},Yjtraincell{1},Xtrain(front:1:row,:),Ytrain_clean(front:1:row),20,'sig');
%                     Y_elm=Y_elm';
%                     RMSEelm((i-1)*5+j,1)=sqrt(mean((Y_elm-Ytrain_clean(front:1:row)).^2));
%                     Y_elm=elmelm(Xjtrain,Yjtrain,Xtrain(front:1:row,:),Ytrain_clean(front:1:row),20,'sig');
%                     Y_elm=Y_elm';
%                     RMSEelm((i-1)*5+j,2)=sqrt(mean((Y_elm-Ytrain_clean(front:1:row)).^2));      
                    rng(1);
                    Mdnet=feedforwardnet(15);
                    Mdnet.trainParam.showWindow=false;
                    rng(1)
                    Mdnet1=train(Mdnet,Xjtraincell{1}',Yjtraincell{1}');
                    Y_net=Mdnet1(Xtrain(front:1:row,:)');
                    Y_elm=Y_net';
                    RMSEelm((i-1)*5+j,1)=sqrt(mean((Y_elm-Ytrain_clean(front:1:row)).^2)); 
                    rng(1);
                    Mdnet=feedforwardnet(15);
                    Mdnet.trainParam.showWindow=false;
                    rng(1)
                    Mdnet1=train(Mdnet,Xjtrain',Yjtrain');
                    Y_net=Mdnet1(Xtrain(front:1:row,:)');
                    Y_elm=Y_net';
                    RMSEelm((i-1)*5+j,2)=sqrt(mean((Y_elm-Ytrain_clean(front:1:row)).^2)); 
                    

                    Y_lr=zeros(row-front+1,1);
                    for pp=front:1:row
                        [~,Yknn] = kNN2(Xjtraincell{1},Yjtraincell{1},3,Xtrain(pp,:));
                        Y_lr(pp-front+1)=mean(Yknn);
                    end
                    
%                     Mdlr=fitlm(Xjtraincell{1},Yjtraincell{1});
%                     Y_lr=Mdlr.predict(Xtrain(front:1:row,:));
                    RMSElr((i-1)*5+j,1)=sqrt(mean((Y_lr-Ytrain_clean(front:1:row)).^2));

                    Y_lr=zeros(row-front+1,1);
                    for pp=front:1:row
                        [~,Yknn] = kNN2(Xjtrain,Yjtrain,3,Xtrain(pp,:));
                        Y_lr(pp-front+1)=mean(Yknn);
                    end
                    
%                     Mdlr=fitlm(Xjtrain,Yjtrain);
%                     Y_lr=Mdlr.predict(Xtrain(front:1:row,:));
                    RMSElr((i-1)*5+j,2)=sqrt(mean((Y_lr-Ytrain_clean(front:1:row)).^2));
                    
                    rng(1);
                    tpT=templateTree('MinLeafSize',1);
                    Mdlrrf=fitrensemble(Xjtraincell{1},Yjtraincell{1},'Learners',tpT,'Method','Bag','NumLearningCycles',50);
                    Y_rf=Mdlrrf.predict(Xtrain(front:1:row,:));
                    RMSEcart((i-1)*5+j,1)=sqrt(mean((Y_rf-Ytrain_clean(front:1:row)).^2));
                    rng(1);
                    tpT=templateTree('MinLeafSize',1);
                    Mdlrrf=fitrensemble(Xjtrain,Yjtrain,'Learners',tpT,'Method','Bag','NumLearningCycles',50);
                    Y_rf=Mdlrrf.predict(Xtrain(front:1:row,:));
                    RMSEcart((i-1)*5+j,2)=sqrt(mean((Y_rf-Ytrain_clean(front:1:row)).^2));
                else
%                     Y_elm=elmelm(Xjtraincell{1},Yjtraincell{1},Xtrain(front:1:back,:),Ytrain_clean(front:1:back),20,'sig');
%                     Y_elm=Y_elm';
%                     RMSEelm((i-1)*5+j,1)=sqrt(mean((Y_elm-Ytrain_clean(front:1:back)).^2));
%                     Y_elm=elmelm(Xjtrain,Yjtrain,Xtrain(front:1:back,:),Ytrain_clean(front:1:back),20,'sig');
%                     Y_elm=Y_elm';
%                     RMSEelm((i-1)*5+j,2)=sqrt(mean((Y_elm-Ytrain_clean(front:1:back)).^2));
                    
                    rng(1);
                    Mdnet=feedforwardnet(15);
                    Mdnet.trainParam.showWindow=false;
                    rng(1)
                    Mdnet1=train(Mdnet,Xjtraincell{1}',Yjtraincell{1}');
                    Y_net=Mdnet1(Xtrain(front:1:back,:)');
                    Y_elm=Y_net';
                    RMSEelm((i-1)*5+j,1)=sqrt(mean((Y_elm-Ytrain_clean(front:1:back)).^2)); 
                    rng(1);
                    Mdnet=feedforwardnet(15);
                    Mdnet.trainParam.showWindow=false;
                    rng(1)
                    Mdnet1=train(Mdnet,Xjtrain',Yjtrain');
                    Y_net=Mdnet1(Xtrain(front:1:back,:)');
                    Y_elm=Y_net';
                    RMSEelm((i-1)*5+j,2)=sqrt(mean((Y_elm-Ytrain_clean(front:1:back)).^2)); 
                    
                    Y_lr=zeros(back-front+1,1);
                    for pp=front:1:back
                        [~,Yknn] = kNN2(Xjtraincell{1},Yjtraincell{1},3,Xtrain(pp,:));
                        Y_lr(pp-front+1)=mean(Yknn);
                    end                      
                    
%                     Mdlr=fitlm(Xjtraincell{1},Yjtraincell{1});
%                     Y_lr=Mdlr.predict(Xtrain(front:1:back,:));
                    RMSElr((i-1)*5+j,1)=sqrt(mean((Y_lr-Ytrain_clean(front:1:back)).^2)); 
                    
                    Y_lr=zeros(back-front+1,1);
                    for pp=front:1:back
                        [~,Yknn] = kNN2(Xjtrain,Yjtrain,3,Xtrain(pp,:));
                        Y_lr(pp-front+1)=mean(Yknn);
                    end                     
                    
%                     Mdlr=fitlm(Xjtrain,Yjtrain);
%                     Y_lr=Mdlr.predict(Xtrain(front:1:back,:));
                    RMSElr((i-1)*5+j,2)=sqrt(mean((Y_lr-Ytrain_clean(front:1:back)).^2));

                    rng(1);
                    tpT=templateTree('MinLeafSize',1);
                    Mdlrrf=fitrensemble(Xjtraincell{1},Yjtraincell{1},'Learners',tpT,'Method','Bag','NumLearningCycles',50);
                    Y_rf=Mdlrrf.predict(Xtrain(front:1:back,:));
                    RMSEcart((i-1)*5+j,1)=sqrt(mean((Y_rf-Ytrain_clean(front:1:back)).^2));
                    rng(1);
                    tpT=templateTree('MinLeafSize',1);
                    Mdlrrf=fitrensemble(Xjtrain,Yjtrain,'Learners',tpT,'Method','Bag','NumLearningCycles',50);
                    Y_rf=Mdlrrf.predict(Xtrain(front:1:back,:));
                    RMSEcart((i-1)*5+j,2)=sqrt(mean((Y_rf-Ytrain_clean(front:1:back)).^2));
                end                  
            end  
            seed=seed+1;
            Y=Y_clean;
        end
        LRCELL(o,percent)={mean(RMSElr)};
        RFCELL(o,percent)={mean(RMSEcart)};
        ELMCELL(o,percent)={mean(RMSEelm)};
    end
end       
KNNCELL=LRCELL;
BPCELL=ELMCE;

end