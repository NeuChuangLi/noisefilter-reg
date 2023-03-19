function [finalnoiseindex] = DROP3RT1(row,X,Y,k,alphaE,alphaD)

[noiseindex] = ENN1(row,X,Y,k,alphaE);
XX=X;
YY=Y;

XX(noiseindex,:)=[];
YY(noiseindex,:)=[];
nrow=size(XX,1);


discell=cell(nrow,1);
for i=1:1:nrow
    distance=sum((XX(i,:)-XX).^2,2);
    [~,index]=sort(distance);
    index(1,:)=[];
    discell(i)={index};
end

iii=[];
for i=1:1:nrow
    with=0;
    without=0;
    rrr=[1:1:nrow]';
    rrr(iii)=[];
    szr=size(rrr,1);

    indass=[];
    for j=1:1:szr
        if ismember(i,discell{rrr(j)}(1:1:9))
            indass=[indass;rrr(j)];
        end
    end
    rowasso=size(indass,1);
    for k=1:1:rowasso
        pp=discell{indass(k)};
        pp2=pp(1:1:9);
        thetaD=alphaD*std(YY(pp(1:1:9)));
        xind=find((pp2-i)==0);
        pp2(xind)=[];
        if abs(YY(indass(k))-mean(YY(pp2)))<=thetaD
            without=without+1;
        end
        if abs(YY(indass(k))-mean(YY(pp(1:1:9))))<=thetaD
            with=with+1;
        end
    end
    
    if without>=with
        for q=1:1:rowasso
            xb=discell{indass(q)};
            xbfi=find(xb==i);
            discell{indass(q)}(xbfi)=[];    
        end
        iii=[iii;i];
    end
end
XX(iii,:)=[];
rrow=size(XX,1);
cleanindex=[];
for i=1:1:rrow
    okk=sum(XX(i,:)-X,2);
    cleanindex1=find(okk==0);
    cleanindex=[cleanindex;cleanindex1];
end
finalnoiseindex=[1:1:row]';
finalnoiseindex(cleanindex)=[];

end

