function [URandIFRforlevel10,URandIFRforlevel20,URandIFRforlevel30,URandIFRforlevel40,URandIFRforlevel50] = URandIFR()

[KEEL_mortgage,KEEL_treasury,KEEL_wankara,KEEL_wizmir,KEEL_ele_2,KEEL_stock,KEEL_concrete,KEEL_compactiv,KEEL_machineCPU,UCI_day,UCI_RBDS,UCI_airquality,UCI_Processed_DJI,KEEL_mv,UCI_Facebook,KEEL_friedman,UCI_music,KEEL_autompg8,UCI_Steelindustry,KEEL_forestfires,KEEL_laser,UCI_gt1] = loaddataset;

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
        lscuojianlv=zeros(5,7);
        lsloujianlv=zeros(5,7);

        for j=1:1:5
            Y=Y_clean;
            rng(100*(percent+1)+j);
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
            zaoshengid=randind(1:1:numofnoise);
            rng(1000*j);
            for s=1:1:numofnoise
                Y(randind(s))=sqrt(0.5)*randn;
            end   
            index_my=My1(row,X,Y,0.5,0.7,5,9);     %1
            index_ENN=ENN1(row,X,Y,9,1);          %2
            index_CVCF=My2(row,X,Y,0.5,1,9,9);           %3
            index_BF=DiscENN1(row,X,Y,9,10);              %4
            index_Allknn=DROP3RT1(row,X,Y,9,1,0.5);      %5
            index_EF=CVCF1(row,X,Y,3);               %6
            index_IPF=IPF1(row,X,Y,10);            %7
            
            row_my=size(index_my,1);
            for rmy=1:1:row_my
                if ismember(index_my(rmy),zaoshengid)==0
                    lscuojianlv(j,1)=lscuojianlv(j,1)+1;
                end
            end
            lscuojianlv(j,1)=lscuojianlv(j,1)/row_my;
            for k=1:1:numofnoise
                if ismember(zaoshengid(k),index_my)==0
                    lsloujianlv(j,1)=lsloujianlv(j,1)+1;
                end
            end   
            lsloujianlv(j,1)=lsloujianlv(j,1)/numofnoise;
            
            row_ENN=size(index_ENN,1);
            for rmy=1:1:row_ENN
                if ismember(index_ENN(rmy),zaoshengid)==0
                    lscuojianlv(j,2)=lscuojianlv(j,2)+1;
                end
            end
            lscuojianlv(j,2)=lscuojianlv(j,2)/row_ENN;
            for k=1:1:numofnoise
                if ismember(zaoshengid(k),index_ENN)==0
                    lsloujianlv(j,2)=lsloujianlv(j,2)+1;
                end
            end
            lsloujianlv(j,2)=lsloujianlv(j,2)/numofnoise;
            
            row_CVCF=size(index_CVCF,1);
            for rmy=1:1:row_CVCF
                if ismember(index_CVCF(rmy),zaoshengid)==0
                    lscuojianlv(j,3)=lscuojianlv(j,3)+1;
                end
            end
            lscuojianlv(j,3)=lscuojianlv(j,3)/row_CVCF;
            for k=1:1:numofnoise
                if ismember(zaoshengid(k),index_CVCF)==0
                    lsloujianlv(j,3)=lsloujianlv(j,3)+1;
                end
            end    
            lsloujianlv(j,3)=lsloujianlv(j,3)/numofnoise;
            
            row_BF=size(index_BF,1);
            for rmy=1:1:row_BF
                if ismember(index_BF(rmy),zaoshengid)==0
                    lscuojianlv(j,4)=lscuojianlv(j,4)+1;
                end
            end
            lscuojianlv(j,4)=lscuojianlv(j,4)/row_BF;
            for k=1:1:numofnoise
                if ismember(zaoshengid(k),index_BF)==0
                    lsloujianlv(j,4)=lsloujianlv(j,4)+1;
                end
            end
            lsloujianlv(j,4)=lsloujianlv(j,4)/numofnoise;
            
            row_Allknn=size(index_Allknn,1);
            for rmy=1:1:row_Allknn
                if ismember(index_Allknn(rmy),zaoshengid)==0
                    lscuojianlv(j,5)=lscuojianlv(j,5)+1;
                end
            end
            lscuojianlv(j,5)=lscuojianlv(j,5)/row_Allknn;
            for k=1:1:numofnoise
                if ismember(zaoshengid(k),index_Allknn)==0
                    lsloujianlv(j,5)=lsloujianlv(j,5)+1;
                end
            end
            lsloujianlv(j,5)=lsloujianlv(j,5)/numofnoise;
            
            row_EF=size(index_EF,1);
            for rmy=1:1:row_EF
                if ismember(index_EF(rmy),zaoshengid)==0
                    lscuojianlv(j,6)=lscuojianlv(j,6)+1;
                end
            end
            lscuojianlv(j,6)=lscuojianlv(j,6)/row_EF;
            for k=1:1:numofnoise
                if ismember(zaoshengid(k),index_EF)==0
                    lsloujianlv(j,6)=lsloujianlv(j,6)+1;
                end
            end
            lsloujianlv(j,6)=lsloujianlv(j,6)/numofnoise;
            
            row_IPF=size(index_IPF,1);
            for rmy=1:1:row_IPF
                if ismember(index_IPF(rmy),zaoshengid)==0
                    lscuojianlv(j,7)=lscuojianlv(j,7)+1;
                end
            end
            lscuojianlv(j,7)=lscuojianlv(j,7)/row_IPF;
            for k=1:1:numofnoise
                if ismember(zaoshengid(k),index_IPF)==0
                    lsloujianlv(j,7)=lsloujianlv(j,7)+1;
                end
            end
            lsloujianlv(j,7)=lsloujianlv(j,7)/numofnoise;           
        end  
        outputcell(i,percent)={[mean(lscuojianlv);mean(lsloujianlv)]};      
    end
end

cuojianyuloujian=zeros(2,7);
for i=1:1:22
    cuojianyuloujian=cuojianyuloujian+outputcell{i,1};
end
URandIFRforlevel10=cuojianyuloujian/22;

cuojianyuloujian=zeros(2,7);
for i=1:1:22
    cuojianyuloujian=cuojianyuloujian+outputcell{i,2};
end
URandIFRforlevel20=cuojianyuloujian/22;

cuojianyuloujian=zeros(2,7);
for i=1:1:22
    cuojianyuloujian=cuojianyuloujian+outputcell{i,3};
end
URandIFRforlevel30=cuojianyuloujian/22;

cuojianyuloujian=zeros(2,7);
for i=1:1:22
    cuojianyuloujian=cuojianyuloujian+outputcell{i,4};
end
URandIFRforlevel40=cuojianyuloujian/22;

cuojianyuloujian=zeros(2,7);
for i=1:1:22
    cuojianyuloujian=cuojianyuloujian+outputcell{i,5};
end
URandIFRforlevel50=cuojianyuloujian/22;


end

