function [KNNoutput,RFoutput,BPoutput,jieguocell,outputcell] = autoexecute()

[KEEL_mortgage,KEEL_treasury,KEEL_wankara,KEEL_wizmir,KEEL_ele_2,KEEL_stock,KEEL_concrete,KEEL_compactiv,KEEL_machineCPU,UCI_day,UCI_RBDS,UCI_airquality,UCI_Processed_DJI,KEEL_mv,UCI_Facebook,KEEL_friedman,UCI_music,KEEL_autompg8,UCI_Steelindustry,KEEL_forestfires,KEEL_laser,UCI_gt1] = loaddata1;

matrixcell=cell(22,1);
outputcell=cell(22,5);
paixumatrix=cell(22,5);
jieguo_1=zeros(3,5);
jieguo_2=zeros(3,5);
jieguo_3=zeros(3,5);
jieguo_4=zeros(3,5);
jieguo_5=zeros(3,5);
jieguo_6=zeros(3,5);
jieguo_7=zeros(3,5);

jieguocell=cell(7,1);
jieguocell(1,1)={jieguo_1};
jieguocell(2,1)={jieguo_2};
jieguocell(3,1)={jieguo_3};
jieguocell(4,1)={jieguo_4};
jieguocell(5,1)={jieguo_5};
jieguocell(6,1)={jieguo_6};
jieguocell(7,1)={jieguo_7};

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

bigmatrix=[];

for xh=1:1:22
    xh
    for xxh=1:1:5
        xxh
        if xxh==1
            perct=0.1;
        end
        if xxh==2
            perct=0.2;
        end
        if xxh==3
            perct=0.3;
        end
        if xxh==4
            perct=0.4;
        end
        if xxh==5
            perct=0.5;
        end        
        RMSEall=noisefiltercompare(100*(xxh+1),perct,matrixcell{xh});
        outputcell(xh,xxh)={RMSEall};
        bigmatrix=[bigmatrix;RMSEall];
    end
end


for xh=1:1:22
    for xxh=1:1:5
        [~,I]=sort(outputcell{xh,xxh},2);
        paixumatrix(xh,xxh)={I(:,1)};
    end
end

for i=1:1:22
    for j=1:1:5
        for k=1:1:7
            if paixumatrix{i,j}(1)==k
                jieguocell{k,1}(1,j)=jieguocell{k,1}(1,j)+1;
            end   
            if paixumatrix{i,j}(2)==k
                jieguocell{k,1}(2,j)=jieguocell{k,1}(2,j)+1;
            end    
            if paixumatrix{i,j}(3)==k
                jieguocell{k,1}(3,j)=jieguocell{k,1}(3,j)+1;
            end            
        end
    end  
end

LR=zeros(5,7);
RF=zeros(5,7);
ELM=zeros(5,7);

for i=1:1:22
    for j=1:1:7
        for k=1:1:5
            LR(k,j)=bigmatrix((i-1)*15+(k-1)*3+1,j)+LR(k,j);
            RF(k,j)=bigmatrix((i-1)*15+(k-1)*3+2,j)+RF(k,j);
            ELM(k,j)=bigmatrix((i-1)*15+(k-1)*3+3,j)+ELM(k,j);
        end
    end
end

LR=LR';
RF=RF';
ELM=ELM';


KNNoutput=LR/22;
RFoutput=RF/22;
BPoutput=ELM/22;


end