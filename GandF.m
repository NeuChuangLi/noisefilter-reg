function [FinalF1score,FinalGmeans,outputcell] = GandF()

[KEEL_mortgage,KEEL_treasury,KEEL_wankara,KEEL_wizmir,KEEL_ele_2,KEEL_stock,KEEL_concrete,KEEL_compactiv,KEEL_machineCPU,UCI_day,UCI_RBDS,UCI_airquality,UCI_Processed_DJI,KEEL_mv,UCI_Facebook,KEEL_friedman,UCI_music,KEEL_autompg8,UCI_Steelindustry,KEEL_forestfires,KEEL_laser,UCI_gt1] = loaddata1;

matrixcell=cell(22,1);
outputcell=cell(22,5);

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

for i=1:1:22
    i
    [row,X,Y]=normalizaion(matrixcell{i});
    Y_clean=Y;
    for percent=1:1:5
        F1score=zeros(5,7);
        Gmeans=zeros(5,7);
        TP=zeros(5,7);
        FN=zeros(5,7);
        FP=zeros(5,7);
        TN=zeros(5,7);

        for j=1:1:5
            Y=Y_clean;
            rng(100*percent+j);
            randind=randperm(row)';
            numofnoise=floor(row*percent*0.1);
            zaoshengid=randind(1:1:numofnoise);
            ganjingid=randind(numofnoise+1:1:end);
            rng(1000*j);
            for s=1:1:numofnoise
                Y(randind(s))=rand;
            end   
            index_my=My1(row,X,Y,0.5,0.7,5,9);     %1
            index_ENN=ENN1(row,X,Y,9,1);          %2
            index_CVCF=My2(row,X,Y,0.5,1,9,9);    %3
            index_BF=DiscENN1(row,X,Y,9,10);    %4
            index_Allknn=DROP3RT1(row,X,Y,9,1,0.5);       %5
            index_EF=CVCF1(row,X,Y,3);           %6
            index_BF2=IPF1(row,X,Y,10);    %4           %6           
            
            row_my=size(index_my,1);
            for rmy=1:1:row_my
                if ismember(index_my(rmy),zaoshengid)==1
                    TP(j,1)=TP(j,1)+1;
                end
                if ismember(index_my(rmy),ganjingid)==1
                    FP(j,1)=FP(j,1)+1;
                end                
            end
            jcganjingid=setdiff(randind,index_my);
            jcrow=size(jcganjingid,1);
            for k=1:1:jcrow
                if ismember(jcganjingid(k),zaoshengid)==1
                    FN(j,1)=FN(j,1)+1;
                end
                if ismember(jcganjingid(k),ganjingid)==1
                    TN(j,1)=TN(j,1)+1;
                end                
            end   
            precision1=TP(j,1)/(TP(j,1)+FP(j,1));
            recall1=TP(j,1)/(TP(j,1)+FN(j,1));
            specifity1=TN(j,1)/(TN(j,1)+FP(j,1));
            F1score(j,1)=2*precision1*recall1/(precision1+recall1);
            Gmeans(j,1)=sqrt(specifity1*recall1);
            if isnan(F1score(j,1))
                F1score(j,1)=0;
            end
            
            row_ENN=size(index_ENN,1);
            for rmy=1:1:row_ENN
                if ismember(index_ENN(rmy),zaoshengid)==1
                    TP(j,2)=TP(j,2)+1;
                end
                if ismember(index_ENN(rmy),ganjingid)==1
                    FP(j,2)=FP(j,2)+1;
                end                
            end
            jcganjingid2=setdiff(randind,index_ENN);
            jcrow2=size(jcganjingid2,1);            
            for k=1:1:jcrow2
                if ismember(jcganjingid2(k),zaoshengid)==1
                    FN(j,2)=FN(j,2)+1;
                end
                if ismember(jcganjingid2(k),ganjingid)==1
                    TN(j,2)=TN(j,2)+1;
                end
            end
            precision2=TP(j,2)/(TP(j,2)+FP(j,2));
            recall2=TP(j,2)/(TP(j,2)+FN(j,2));
            specifity2=TN(j,2)/(TN(j,2)+FP(j,2));
            F1score(j,2)=2*precision2*recall2/(precision2+recall2);
            Gmeans(j,2)=sqrt(specifity2*recall2);
            if isnan(F1score(j,2))
                F1score(j,2)=0;
            end            
            
            row_CVCF=size(index_CVCF,1);
            for rmy=1:1:row_CVCF
                if ismember(index_CVCF(rmy),zaoshengid)==1
                    TP(j,3)=TP(j,3)+1;
                end
                if ismember(index_CVCF(rmy),ganjingid)==1
                    FP(j,3)=FP(j,3)+1;
                end                
            end
            jcganjingid3=setdiff(randind,index_CVCF);
            jcrow3=size(jcganjingid3,1); 
            for k=1:1:jcrow3
                if ismember(jcganjingid3(k),zaoshengid)==1
                    FN(j,3)=FN(j,3)+1;
                end
                if ismember(jcganjingid3(k),ganjingid)==1
                    TN(j,3)=TN(j,3)+1;
                end                
            end    
            precision3=TP(j,3)/(TP(j,3)+FP(j,3));
            recall3=TP(j,3)/(TP(j,3)+FN(j,3));
            specifity3=TN(j,3)/(TN(j,3)+FP(j,3));
            F1score(j,3)=2*precision3*recall3/(precision3+recall3);
            Gmeans(j,3)=sqrt(specifity3*recall3);
            if isnan(F1score(j,3))
                F1score(j,3)=0;
            end
            
            row_BF=size(index_BF,1);
            for rmy=1:1:row_BF
                if ismember(index_BF(rmy),zaoshengid)==1
                    TP(j,4)=TP(j,4)+1;
                end
                if ismember(index_BF(rmy),ganjingid)==1
                    FP(j,4)=FP(j,4)+1;
                end
            end
            jcganjingid4=setdiff(randind,index_BF);
            jcrow4=size(jcganjingid4,1);
            for k=1:1:jcrow4
                if ismember(jcganjingid4(k),zaoshengid)==1
                    FN(j,4)=FN(j,4)+1;
                end
                if ismember(jcganjingid4(k),ganjingid)==1
                    TN(j,4)=TN(j,4)+1;
                end
            end
            precision4=TP(j,4)/(TP(j,4)+FP(j,4));
            recall4=TP(j,4)/(TP(j,4)+FN(j,4));
            specifity4=TN(j,4)/(TN(j,4)+FP(j,4));
            F1score(j,4)=2*precision4*recall4/(precision4+recall4);
            Gmeans(j,4)=sqrt(specifity4*recall4);
            if isnan(F1score(j,4))
                F1score(j,4)=0;
            end
            
            row_Allknn=size(index_Allknn,1);
            for rmy=1:1:row_Allknn
                if ismember(index_Allknn(rmy),zaoshengid)==1
                    TP(j,5)=TP(j,5)+1;
                end
                if ismember(index_Allknn(rmy),ganjingid)==1
                    FP(j,5)=FP(j,5)+1;
                end                
            end
            jcganjingid5=setdiff(randind,index_Allknn);
            jcrow5=size(jcganjingid5,1);
            for k=1:1:jcrow5
                if ismember(jcganjingid5(k),zaoshengid)==1
                    FN(j,5)=FN(j,5)+1;
                end
                if ismember(jcganjingid5(k),ganjingid)==1
                    TN(j,5)=TN(j,5)+1;
                end
            end
            precision5=TP(j,5)/(TP(j,5)+FP(j,5));
            recall5=TP(j,5)/(TP(j,5)+FN(j,5));
            specifity5=TN(j,5)/(TN(j,5)+FP(j,5));
            F1score(j,5)=2*precision5*recall5/(precision5+recall5);
            Gmeans(j,5)=sqrt(specifity5*recall5);
            if isnan(F1score(j,5))
                F1score(j,5)=0;
            end            
            
            row_EF=size(index_EF,1);
            for rmy=1:1:row_EF
                if ismember(index_EF(rmy),zaoshengid)==1
                    TP(j,6)=TP(j,6)+1;
                end
                if ismember(index_EF(rmy),ganjingid)==1
                    FP(j,6)=FP(j,6)+1;
                end
            end
            jcganjingid6=setdiff(randind,index_EF);
            jcrow6=size(jcganjingid6,1);
            for k=1:1:jcrow6
                if ismember(jcganjingid6(k),zaoshengid)==1
                    FN(j,6)=FN(j,6)+1;
                end
                if ismember(jcganjingid6(k),ganjingid)==1
                    TN(j,6)=TN(j,6)+1;
                end
            end     
            precision6=TP(j,6)/(TP(j,6)+FP(j,6));
            recall6=TP(j,6)/(TP(j,6)+FN(j,6));
            specifity6=TN(j,6)/(TN(j,6)+FP(j,6));
            F1score(j,6)=2*precision6*recall6/(precision6+recall6);
            Gmeans(j,6)=sqrt(specifity6*recall6);     
            if isnan(F1score(j,6))
                F1score(j,6)=0;
            end

            row_BF2=size(index_BF2,1);
            for rmy=1:1:row_BF2
                if ismember(index_BF2(rmy),zaoshengid)==1
                    TP(j,7)=TP(j,7)+1;
                end
                if ismember(index_BF2(rmy),ganjingid)==1
                    FP(j,7)=FP(j,7)+1;
                end
            end
            jcganjingid7=setdiff(randind,index_BF2);
            jcrow7=size(jcganjingid7,1);
            for k=1:1:jcrow7
                if ismember(jcganjingid7(k),zaoshengid)==1
                    FN(j,7)=FN(j,7)+1;
                end
                if ismember(jcganjingid7(k),ganjingid)==1
                    TN(j,7)=TN(j,7)+1;
                end
            end
            precision7=TP(j,7)/(TP(j,7)+FP(j,7));
            recall7=TP(j,7)/(TP(j,7)+FN(j,7));
            specifity7=TN(j,7)/(TN(j,7)+FP(j,7));
            F1score(j,7)=2*precision7*recall7/(precision7+recall7);
            Gmeans(j,7)=sqrt(specifity7*recall7);
            if isnan(F1score(j,7))
                F1score(j,7)=0;
            end
                           
        end  
        outputcell(i,percent)={[mean(F1score);mean(Gmeans)]};      
    end
end

FinalF1score=zeros(5,7);
FinalGmeans=zeros(5,7);
for j=1:1:5
    for i=1:1:22
        FinalF1score(j,:)=FinalF1score(j,:)+outputcell{i,j}(1,:);
        FinalGmeans(j,:)=FinalGmeans(j,:)+outputcell{i,j}(2,:);
    end
end
FinalF1score=FinalF1score/22;
FinalGmeans=FinalGmeans/22;
FinalF1score=FinalF1score';
FinalGmeans=FinalGmeans';

end

