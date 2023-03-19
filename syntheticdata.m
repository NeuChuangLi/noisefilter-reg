function [cjylj1,cjylj2,cjylj3,cjylj4,cjylj5,cjylj6,GandF1,GandF2,GandF3,GandF4,GandF5,GandF6] = syntheticdata()

x1=[0.01:0.01:1]';
x2=[0.01:0.01:1]';
x3=[0.01:0.01:1]';

rng(10);
vec10=randperm(100)';
x2=x2(vec10);
vec11=randperm(100)';
x3=x3(vec11);

y1=0.5*x1.*sin(2*pi*x1)+0.5;
y2=0.5*x1+0.3*x2;
y3=exp(-2*(x1+1).^2)+0.5*(x2.*x2+sin(pi*x3));

y1un=y1;
y2un=y2;
y3un=y3;
y1gn=y1;
y2gn=y2;
y3gn=y3;

rng(1);
vec1=randperm(100)';
noiseindex1=vec1(1:1:30);
vec2=randperm(100)';
noiseindex2=vec2(1:1:30);

%uniform noise
miny1=min(y1);
miny2=min(y2);
miny3=min(y3);
maxy1=max(y1);
maxy2=max(y2);
maxy3=max(y3);

rng(2);
noiselabel1=(maxy1-miny1)*rand(30,1)+miny1;
noiselabel2=(maxy2-miny2)*rand(30,1)+miny2;
noiselabel3=(maxy3-miny3)*rand(30,1)+miny3;

y1un(noiseindex1,:)=noiselabel1;
y2un(noiseindex1,:)=noiselabel2;
y3un(noiseindex1,:)=noiselabel3;

%gaussian noise
rng(3);
noiselabel11=sqrt(0.5)*randn(30,1);
noiselabel22=sqrt(0.5)*randn(30,1);
noiselabel33=sqrt(0.5)*randn(30,1);
y1gn(noiseindex2,:)=noiselabel11+y1gn(noiseindex2,:);
y2gn(noiseindex2,:)=noiselabel22+y2gn(noiseindex2,:);
y3gn(noiseindex2,:)=noiselabel33+y3gn(noiseindex2,:);

%filter
F1un1=My1(100,x1,y1un,0.5,0.7,5,9);      
F2un1=ENN1(100,x1,y1un,9,1);                                    
F3un1=My2(100,x1,y1un,0.5,1,9,9);                          
F4un1=DiscENN1(100,x1,y1un,9,10);                                
F5un1=DROP3RT1(100,x1,y1un,9,1,0.5);                         
F6un1=CVCF1(100,x1,y1un,3);                                      
F7un1=IPF1(100,x1,y1un,10);

F1un2=My1(100,[x1 x2],y2un,0.5,0.7,5,9);      
F2un2=ENN1(100,[x1 x2],y2un,9,1);                                    
F3un2=My2(100,[x1 x2],y2un,0.5,1,9,9);                          
F4un2=DiscENN1(100,[x1 x2],y2un,9,10);                                
F5un2=DROP3RT1(100,[x1 x2],y2un,9,1,0.5);                         
F6un2=CVCF1(100,[x1 x2],y2un,3);                                      
F7un2=IPF1(100,[x1 x2],y2un,10);

F1un3=My1(100,[x1 x2 x3],y3un,0.5,0.7,5,9);      
F2un3=ENN1(100,[x1 x2 x3],y3un,9,1);                                    
F3un3=My2(100,[x1 x2 x3],y3un,0.5,1,9,9);                          
F4un3=DiscENN1(100,[x1 x2 x3],y3un,9,10);                                
F5un3=DROP3RT1(100,[x1 x2 x3],y3un,9,1,0.5);                         
F6un3=CVCF1(100,[x1 x2 x3],y3un,3);                                      
F7un3=IPF1(100,[x1 x2 x3],y3un,10);

F1gn1=My1(100,x1,y1gn,0.5,0.7,5,9);      
F2gn1=ENN1(100,x1,y1gn,9,1);                                    
F3gn1=My2(100,x1,y1gn,0.5,1,9,9);                          
F4gn1=DiscENN1(100,x1,y1gn,9,10);                                
F5gn1=DROP3RT1(100,x1,y1gn,9,1,0.5);                         
F6gn1=CVCF1(100,x1,y1gn,3);                                      
F7gn1=IPF1(100,x1,y1gn,10); 

F1gn2=My1(100,[x1 x2],y2gn,0.5,0.7,5,9);      
F2gn2=ENN1(100,[x1 x2],y2gn,9,1);                                    
F3gn2=My2(100,[x1 x2],y2gn,0.5,1,9,9);                          
F4gn2=DiscENN1(100,[x1 x2],y2gn,9,10);                                
F5gn2=DROP3RT1(100,[x1 x2],y2gn,9,1,0.5);                         
F6gn2=CVCF1(100,[x1 x2],y2gn,3);                                      
F7gn2=IPF1(100,[x1 x2],y2gn,10);

F1gn3=My1(100,[x1 x2 x3],y3gn,0.5,0.7,5,9);      
F2gn3=ENN1(100,[x1 x2 x3],y3gn,9,1);                                    
F3gn3=My2(100,[x1 x2 x3],y3gn,0.5,1,9,9);                          
F4gn3=DiscENN1(100,[x1 x2 x3],y3gn,9,10);                                
F5gn3=DROP3RT1(100,[x1 x2 x3],y3gn,9,1,0.5);                         
F6gn3=CVCF1(100,[x1 x2 x3],y3gn,3);                                      
F7gn3=IPF1(100,[x1 x2 x3],y3gn,10);

%¥ÌºÏ¬ ”Î¬©ºÏ¬ 
cjylj1=zeros(7,2);
cjylj2=zeros(7,2);
cjylj3=zeros(7,2);
cjylj4=zeros(7,2);
cjylj5=zeros(7,2);
cjylj6=zeros(7,2);

nrow1=size(F1un1,1);
nrow2=size(F2un1,1);
nrow3=size(F3un1,1);
nrow4=size(F4un1,1);
nrow5=size(F5un1,1);
nrow6=size(F6un1,1);
nrow7=size(F7un1,1);

for j=1:1:nrow1
    if ismember(F1un1(j),noiseindex1)==0
        cjylj1(1,1)=cjylj1(1,1)+1;
    end
end
cjylj1(1,1)=cjylj1(1,1)/nrow1;
for j=1:1:nrow2
    if ismember(F2un1(j),noiseindex1)==0
        cjylj1(2,1)=cjylj1(2,1)+1;
    end
end   
cjylj1(2,1)=cjylj1(2,1)/nrow2;
for j=1:1:nrow3
    if ismember(F3un1(j),noiseindex1)==0
        cjylj1(3,1)=cjylj1(3,1)+1;
    end
end    
cjylj1(3,1)=cjylj1(3,1)/nrow3;
for j=1:1:nrow4
    if ismember(F4un1(j),noiseindex1)==0
        cjylj1(4,1)=cjylj1(4,1)+1;
    end
end
cjylj1(4,1)=cjylj1(4,1)/nrow4;
for j=1:1:nrow5
    if ismember(F5un1(j),noiseindex1)==0
        cjylj1(5,1)=cjylj1(5,1)+1;
    end
end
cjylj1(5,1)=cjylj1(5,1)/nrow5;
for j=1:1:nrow6
    if ismember(F6un1(j),noiseindex1)==0
        cjylj1(6,1)=cjylj1(6,1)+1;
    end
end
cjylj1(6,1)=cjylj1(6,1)/nrow6;
for j=1:1:nrow7
    if ismember(F7un1(j),noiseindex1)==0
        cjylj1(7,1)=cjylj1(7,1)+1;
    end
end
cjylj1(7,1)=cjylj1(7,1)/nrow7;

for j=1:1:30
    if ismember(noiseindex1(j),F1un1)==0
        cjylj1(1,2)=cjylj1(1,2)+1;
    end
end
cjylj1(1,2)=cjylj1(1,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F2un1)==0
        cjylj1(2,2)=cjylj1(2,2)+1;
    end
end
cjylj1(2,2)=cjylj1(2,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F3un1)==0
        cjylj1(3,2)=cjylj1(3,2)+1;
    end
end
cjylj1(3,2)=cjylj1(3,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F4un1)==0
        cjylj1(4,2)=cjylj1(4,2)+1;
    end
end
cjylj1(4,2)=cjylj1(4,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F5un1)==0
        cjylj1(5,2)=cjylj1(5,2)+1;
    end
end
cjylj1(5,2)=cjylj1(5,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F6un1)==0
        cjylj1(6,2)=cjylj1(6,2)+1;
    end
end
cjylj1(6,2)=cjylj1(6,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F7un1)==0
        cjylj1(7,2)=cjylj1(7,2)+1;
    end
end
cjylj1(7,2)=cjylj1(7,2)/30;

nrow1=size(F1un2,1);
nrow2=size(F2un2,1);
nrow3=size(F3un2,1);
nrow4=size(F4un2,1);
nrow5=size(F5un2,1);
nrow6=size(F6un2,1);
nrow7=size(F7un2,1);

for j=1:1:nrow1
    if ismember(F1un2(j),noiseindex1)==0
        cjylj2(1,1)=cjylj2(1,1)+1;
    end
end
cjylj2(1,1)=cjylj2(1,1)/nrow1;
for j=1:1:nrow2
    if ismember(F2un2(j),noiseindex1)==0
        cjylj2(2,1)=cjylj2(2,1)+1;
    end
end   
cjylj2(2,1)=cjylj2(2,1)/nrow2;
for j=1:1:nrow3
    if ismember(F3un2(j),noiseindex1)==0
        cjylj2(3,1)=cjylj2(3,1)+1;
    end
end    
cjylj2(3,1)=cjylj2(3,1)/nrow3;
for j=1:1:nrow4
    if ismember(F4un2(j),noiseindex1)==0
        cjylj2(4,1)=cjylj2(4,1)+1;
    end
end
cjylj2(4,1)=cjylj2(4,1)/nrow4;
for j=1:1:nrow5
    if ismember(F5un2(j),noiseindex1)==0
        cjylj2(5,1)=cjylj2(5,1)+1;
    end
end
cjylj2(5,1)=cjylj2(5,1)/nrow5;
for j=1:1:nrow6
    if ismember(F6un2(j),noiseindex1)==0
        cjylj2(6,1)=cjylj2(6,1)+1;
    end
end
cjylj2(6,1)=cjylj2(6,1)/nrow6;
for j=1:1:nrow7
    if ismember(F7un2(j),noiseindex1)==0
        cjylj2(7,1)=cjylj2(7,1)+1;
    end
end
cjylj2(7,1)=cjylj2(7,1)/nrow7;

for j=1:1:30
    if ismember(noiseindex1(j),F1un2)==0
        cjylj2(1,2)=cjylj2(1,2)+1;
    end
end
cjylj2(1,2)=cjylj2(1,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F2un2)==0
        cjylj2(2,2)=cjylj2(2,2)+1;
    end
end
cjylj2(2,2)=cjylj2(2,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F3un2)==0
        cjylj2(3,2)=cjylj2(3,2)+1;
    end
end
cjylj2(3,2)=cjylj2(3,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F4un2)==0
        cjylj2(4,2)=cjylj2(4,2)+1;
    end
end
cjylj2(4,2)=cjylj2(4,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F5un2)==0
        cjylj2(5,2)=cjylj2(5,2)+1;
    end
end
cjylj2(5,2)=cjylj2(5,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F6un2)==0
        cjylj2(6,2)=cjylj2(6,2)+1;
    end
end
cjylj2(6,2)=cjylj2(6,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F7un2)==0
        cjylj2(7,2)=cjylj2(7,2)+1;
    end
end
cjylj2(7,2)=cjylj2(7,2)/30;

nrow1=size(F1un3,1);
nrow2=size(F2un3,1);
nrow3=size(F3un3,1);
nrow4=size(F4un3,1);
nrow5=size(F5un3,1);
nrow6=size(F6un3,1);
nrow7=size(F7un3,1);

for j=1:1:nrow1
    if ismember(F1un3(j),noiseindex1)==0
        cjylj3(1,1)=cjylj3(1,1)+1;
    end
end
cjylj3(1,1)=cjylj3(1,1)/nrow1;
for j=1:1:nrow2
    if ismember(F2un3(j),noiseindex1)==0
        cjylj3(2,1)=cjylj3(2,1)+1;
    end
end   
cjylj3(2,1)=cjylj3(2,1)/nrow2;
for j=1:1:nrow3
    if ismember(F3un3(j),noiseindex1)==0
        cjylj3(3,1)=cjylj3(3,1)+1;
    end
end    
cjylj3(3,1)=cjylj3(3,1)/nrow3;
for j=1:1:nrow4
    if ismember(F4un3(j),noiseindex1)==0
        cjylj3(4,1)=cjylj3(4,1)+1;
    end
end
cjylj3(4,1)=cjylj3(4,1)/nrow4;
for j=1:1:nrow5
    if ismember(F5un3(j),noiseindex1)==0
        cjylj3(5,1)=cjylj3(5,1)+1;
    end
end
cjylj3(5,1)=cjylj3(5,1)/nrow5;
for j=1:1:nrow6
    if ismember(F6un3(j),noiseindex1)==0
        cjylj3(6,1)=cjylj3(6,1)+1;
    end
end
cjylj3(6,1)=cjylj3(6,1)/nrow6;
for j=1:1:nrow7
    if ismember(F7un3(j),noiseindex1)==0
        cjylj3(7,1)=cjylj3(7,1)+1;
    end
end
cjylj3(7,1)=cjylj3(7,1)/nrow7;

for j=1:1:30
    if ismember(noiseindex1(j),F1un3)==0
        cjylj3(1,2)=cjylj3(1,2)+1;
    end
end
cjylj3(1,2)=cjylj3(1,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F2un3)==0
        cjylj3(2,2)=cjylj3(2,2)+1;
    end
end
cjylj3(2,2)=cjylj3(2,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F3un3)==0
        cjylj3(3,2)=cjylj3(3,2)+1;
    end
end
cjylj3(3,2)=cjylj3(3,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F4un3)==0
        cjylj3(4,2)=cjylj3(4,2)+1;
    end
end
cjylj3(4,2)=cjylj3(4,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F5un3)==0
        cjylj3(5,2)=cjylj3(5,2)+1;
    end
end
cjylj3(5,2)=cjylj3(5,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F6un3)==0
        cjylj3(6,2)=cjylj3(6,2)+1;
    end
end
cjylj3(6,2)=cjylj3(6,2)/30;
for j=1:1:30
    if ismember(noiseindex1(j),F7un3)==0
        cjylj3(7,2)=cjylj3(7,2)+1;
    end
end
cjylj3(7,2)=cjylj3(7,2)/30;

nrow1=size(F1gn1,1);
nrow2=size(F2gn1,1);
nrow3=size(F3gn1,1);
nrow4=size(F4gn1,1);
nrow5=size(F5gn1,1);
nrow6=size(F6gn1,1);
nrow7=size(F7gn1,1);

for j=1:1:nrow1
    if ismember(F1gn1(j),noiseindex2)==0
        cjylj4(1,1)=cjylj4(1,1)+1;
    end
end
cjylj4(1,1)=cjylj4(1,1)/nrow1;
for j=1:1:nrow2
    if ismember(F2gn1(j),noiseindex2)==0
        cjylj4(2,1)=cjylj4(2,1)+1;
    end
end   
cjylj4(2,1)=cjylj4(2,1)/nrow2;
for j=1:1:nrow3
    if ismember(F3gn1(j),noiseindex2)==0
        cjylj4(3,1)=cjylj4(3,1)+1;
    end
end    
cjylj4(3,1)=cjylj4(3,1)/nrow3;
for j=1:1:nrow4
    if ismember(F4gn1(j),noiseindex2)==0
        cjylj4(4,1)=cjylj4(4,1)+1;
    end
end
cjylj4(4,1)=cjylj4(4,1)/nrow4;
for j=1:1:nrow5
    if ismember(F5gn1(j),noiseindex2)==0
        cjylj4(5,1)=cjylj4(5,1)+1;
    end
end
cjylj4(5,1)=cjylj4(5,1)/nrow5;
for j=1:1:nrow6
    if ismember(F6gn1(j),noiseindex2)==0
        cjylj4(6,1)=cjylj4(6,1)+1;
    end
end
cjylj4(6,1)=cjylj4(6,1)/nrow6;
for j=1:1:nrow7
    if ismember(F7gn1(j),noiseindex2)==0
        cjylj4(7,1)=cjylj4(7,1)+1;
    end
end
cjylj4(7,1)=cjylj4(7,1)/nrow7;

for j=1:1:30
    if ismember(noiseindex2(j),F1gn1)==0
        cjylj4(1,2)=cjylj4(1,2)+1;
    end
end
cjylj4(1,2)=cjylj4(1,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F2gn1)==0
        cjylj4(2,2)=cjylj4(2,2)+1;
    end
end
cjylj4(2,2)=cjylj4(2,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F3gn1)==0
        cjylj4(3,2)=cjylj4(3,2)+1;
    end
end
cjylj4(3,2)=cjylj4(3,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F4gn1)==0
        cjylj4(4,2)=cjylj4(4,2)+1;
    end
end
cjylj4(4,2)=cjylj4(4,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F5gn1)==0
        cjylj4(5,2)=cjylj4(5,2)+1;
    end
end
cjylj4(5,2)=cjylj4(5,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F6gn1)==0
        cjylj4(6,2)=cjylj4(6,2)+1;
    end
end
cjylj4(6,2)=cjylj4(6,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F7gn1)==0
        cjylj4(7,2)=cjylj4(7,2)+1;
    end
end
cjylj4(7,2)=cjylj4(7,2)/30;

nrow1=size(F1gn2,1);
nrow2=size(F2gn2,1);
nrow3=size(F3gn2,1);
nrow4=size(F4gn2,1);
nrow5=size(F5gn2,1);
nrow6=size(F6gn2,1);
nrow7=size(F7gn2,1);

for j=1:1:nrow1
    if ismember(F1gn2(j),noiseindex2)==0
        cjylj5(1,1)=cjylj5(1,1)+1;
    end
end
cjylj5(1,1)=cjylj5(1,1)/nrow1;
for j=1:1:nrow2
    if ismember(F2gn2(j),noiseindex2)==0
        cjylj5(2,1)=cjylj5(2,1)+1;
    end
end   
cjylj5(2,1)=cjylj5(2,1)/nrow2;
for j=1:1:nrow3
    if ismember(F3gn2(j),noiseindex2)==0
        cjylj5(3,1)=cjylj5(3,1)+1;
    end
end    
cjylj5(3,1)=cjylj5(3,1)/nrow3;
for j=1:1:nrow4
    if ismember(F4gn2(j),noiseindex2)==0
        cjylj5(4,1)=cjylj5(4,1)+1;
    end
end
cjylj5(4,1)=cjylj5(4,1)/nrow4;
for j=1:1:nrow5
    if ismember(F5gn2(j),noiseindex2)==0
        cjylj5(5,1)=cjylj5(5,1)+1;
    end
end
cjylj5(5,1)=cjylj5(5,1)/nrow5;
for j=1:1:nrow6
    if ismember(F6gn2(j),noiseindex2)==0
        cjylj5(6,1)=cjylj5(6,1)+1;
    end
end
cjylj5(6,1)=cjylj5(6,1)/nrow6;
for j=1:1:nrow7
    if ismember(F7gn2(j),noiseindex2)==0
        cjylj5(7,1)=cjylj5(7,1)+1;
    end
end
cjylj5(7,1)=cjylj5(7,1)/nrow7;

for j=1:1:30
    if ismember(noiseindex2(j),F1gn2)==0
        cjylj5(1,2)=cjylj5(1,2)+1;
    end
end
cjylj5(1,2)=cjylj5(1,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F2gn2)==0
        cjylj5(2,2)=cjylj5(2,2)+1;
    end
end
cjylj5(2,2)=cjylj5(2,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F3gn2)==0
        cjylj5(3,2)=cjylj5(3,2)+1;
    end
end
cjylj5(3,2)=cjylj5(3,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F4gn2)==0
        cjylj5(4,2)=cjylj5(4,2)+1;
    end
end
cjylj5(4,2)=cjylj5(4,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F5gn2)==0
        cjylj5(5,2)=cjylj5(5,2)+1;
    end
end
cjylj5(5,2)=cjylj5(5,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F6gn2)==0
        cjylj5(6,2)=cjylj5(6,2)+1;
    end
end
cjylj5(6,2)=cjylj5(6,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F7gn2)==0
        cjylj5(7,2)=cjylj5(7,2)+1;
    end
end
cjylj5(7,2)=cjylj5(7,2)/30;

nrow1=size(F1gn3,1);
nrow2=size(F2gn3,1);
nrow3=size(F3gn3,1);
nrow4=size(F4gn3,1);
nrow5=size(F5gn3,1);
nrow6=size(F6gn3,1);
nrow7=size(F7gn3,1);

for j=1:1:nrow1
    if ismember(F1gn3(j),noiseindex2)==0
        cjylj6(1,1)=cjylj6(1,1)+1;
    end
end
cjylj6(1,1)=cjylj6(1,1)/nrow1;
for j=1:1:nrow2
    if ismember(F2gn3(j),noiseindex2)==0
        cjylj6(2,1)=cjylj6(2,1)+1;
    end
end   
cjylj6(2,1)=cjylj6(2,1)/nrow2;
for j=1:1:nrow3
    if ismember(F3gn3(j),noiseindex2)==0
        cjylj6(3,1)=cjylj6(3,1)+1;
    end
end    
cjylj6(3,1)=cjylj6(3,1)/nrow3;
for j=1:1:nrow4
    if ismember(F4gn3(j),noiseindex2)==0
        cjylj6(4,1)=cjylj6(4,1)+1;
    end
end
cjylj6(4,1)=cjylj6(4,1)/nrow4;
for j=1:1:nrow5
    if ismember(F5gn3(j),noiseindex2)==0
        cjylj6(5,1)=cjylj6(5,1)+1;
    end
end
cjylj6(5,1)=cjylj6(5,1)/nrow5;
for j=1:1:nrow6
    if ismember(F6gn3(j),noiseindex2)==0
        cjylj6(6,1)=cjylj6(6,1)+1;
    end
end
cjylj6(6,1)=cjylj6(6,1)/nrow6;
for j=1:1:nrow7
    if ismember(F7gn3(j),noiseindex2)==0
        cjylj6(7,1)=cjylj6(7,1)+1;
    end
end
cjylj6(7,1)=cjylj6(7,1)/nrow7;

for j=1:1:30
    if ismember(noiseindex2(j),F1gn3)==0
        cjylj6(1,2)=cjylj6(1,2)+1;
    end
end
cjylj6(1,2)=cjylj6(1,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F2gn3)==0
        cjylj6(2,2)=cjylj6(2,2)+1;
    end
end
cjylj6(2,2)=cjylj6(2,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F3gn3)==0
        cjylj6(3,2)=cjylj6(3,2)+1;
    end
end
cjylj6(3,2)=cjylj6(3,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F4gn3)==0
        cjylj6(4,2)=cjylj6(4,2)+1;
    end
end
cjylj6(4,2)=cjylj6(4,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F5gn3)==0
        cjylj6(5,2)=cjylj6(5,2)+1;
    end
end
cjylj6(5,2)=cjylj6(5,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F6gn3)==0
        cjylj6(6,2)=cjylj6(6,2)+1;
    end
end
cjylj6(6,2)=cjylj6(6,2)/30;
for j=1:1:30
    if ismember(noiseindex2(j),F7gn3)==0
        cjylj6(7,2)=cjylj6(7,2)+1;
    end
end
cjylj6(7,2)=cjylj6(7,2)/30;

%Gmeans and F1socre
GandF1=zeros(7,2);
GandF2=zeros(7,2);
GandF3=zeros(7,2);
GandF4=zeros(7,2);
GandF5=zeros(7,2);
GandF6=zeros(7,2);
TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F1un1,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F1un1(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F1un1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F1un1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF1(1,1)=F1score;
GandF1(1,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F2un1,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F2un1(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F2un1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F2un1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF1(2,1)=F1score;
GandF1(2,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F3un1,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F3un1(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F3un1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F3un1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF1(3,1)=F1score;
GandF1(3,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F4un1,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F4un1(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F4un1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F4un1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF1(4,1)=F1score;
GandF1(4,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F5un1,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F5un1(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F5un1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F5un1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF1(5,1)=F1score;
GandF1(5,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F6un1,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F6un1(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F6un1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F6un1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF1(6,1)=F1score;
GandF1(6,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F7un1,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F7un1(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F7un1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F7un1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF1(7,1)=F1score;
GandF1(7,2)=Gmeans;



TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F1un2,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F1un2(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F1un2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F1un2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF2(1,1)=F1score;
GandF2(1,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F2un2,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F2un2(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F2un2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F2un2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF2(2,1)=F1score;
GandF2(2,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F3un2,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F3un2(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F3un2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F3un2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF2(3,1)=F1score;
GandF2(3,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F4un2,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F4un2(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F4un2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F4un2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF2(4,1)=F1score;
GandF2(4,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F5un2,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F5un2(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F5un2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F5un2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF2(5,1)=F1score;
GandF2(5,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F6un2,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F6un2(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F6un2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F6un2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF2(6,1)=F1score;
GandF2(6,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F7un2,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F7un2(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F7un2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F7un2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF2(7,1)=F1score;
GandF2(7,2)=Gmeans;


TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F1un3,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F1un3(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F1un3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F1un3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF3(1,1)=F1score;
GandF3(1,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F2un3,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F2un3(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F2un3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F2un3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF3(2,1)=F1score;
GandF3(2,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F3un3,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F3un3(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F3un3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F3un3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF3(3,1)=F1score;
GandF3(3,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F4un3,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F4un3(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F4un3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F4un3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF3(4,1)=F1score;
GandF3(4,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F5un3,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F5un3(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F5un3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F5un3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF3(5,1)=F1score;
GandF3(5,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F6un3,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F6un3(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F6un3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F6un3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF3(6,1)=F1score;
GandF3(6,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F7un3,1);
ganjingid=vec1(31:1:100);
for i=1:1:roww
    if ismember(F7un3(i),noiseindex1)==1
        TP=TP+1;
    end
    if ismember(F7un3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec1,F7un3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex1)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF3(7,1)=F1score;
GandF3(7,2)=Gmeans;



TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F1gn1,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F1gn1(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F1gn1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F1gn1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF4(1,1)=F1score;
GandF4(1,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F2gn1,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F2gn1(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F2gn1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F2gn1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF4(2,1)=F1score;
GandF4(2,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F3gn1,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F3gn1(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F3gn1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F3gn1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF4(3,1)=F1score;
GandF4(3,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F4gn1,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F4gn1(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F4gn1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F4gn1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF4(4,1)=F1score;
GandF4(4,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F5gn1,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F5gn1(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F5gn1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F5gn1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF4(5,1)=F1score;
GandF4(5,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F6gn1,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F6gn1(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F6gn1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F6gn1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF4(6,1)=F1score;
GandF4(6,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F7gn1,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F7gn1(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F7gn1(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F7gn1);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF4(7,1)=F1score;
GandF4(7,2)=Gmeans;




TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F1gn2,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F1gn2(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F1gn2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F1gn2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF5(1,1)=F1score;
GandF5(1,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F2gn2,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F2gn2(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F2gn2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F2gn2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF5(2,1)=F1score;
GandF5(2,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F3gn2,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F3gn2(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F3gn2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F3gn2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF5(3,1)=F1score;
GandF5(3,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F4gn2,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F4gn2(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F4gn2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F4gn2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF5(4,1)=F1score;
GandF5(4,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F5gn2,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F5gn2(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F5gn2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F5gn2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF5(5,1)=F1score;
GandF5(5,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F6gn2,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F6gn2(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F6gn2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F6gn2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF5(6,1)=F1score;
GandF5(6,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F7gn2,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F7gn2(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F7gn2(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F7gn2);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF5(7,1)=F1score;
GandF5(7,2)=Gmeans;



TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F1gn3,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F1gn3(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F1gn3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F1gn3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF6(1,1)=F1score;
GandF6(1,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F2gn3,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F2gn3(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F2gn3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F2gn3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF6(2,1)=F1score;
GandF6(2,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F3gn3,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F3gn3(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F3gn3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F3gn3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF6(3,1)=F1score;
GandF6(3,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F4gn3,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F4gn3(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F4gn3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F4gn3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF6(4,1)=F1score;
GandF6(4,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F5gn3,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F5gn3(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F5gn3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F5gn3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF6(5,1)=F1score;
GandF6(5,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F6gn3,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F6gn3(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F6gn3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F6gn3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF6(6,1)=F1score;
GandF6(6,2)=Gmeans;

TP=0;
FP=0;
FN=0;
TN=0;
roww=size(F7gn3,1);
ganjingid=vec2(31:1:100);
for i=1:1:roww
    if ismember(F7gn3(i),noiseindex2)==1
        TP=TP+1;
    end
    if ismember(F7gn3(i),ganjingid)==1
        FP=FP+1;
    end                
end
jcganjingid=setdiff(vec2,F7gn3);
jcrow=size(jcganjingid,1);
for k=1:1:jcrow
    if ismember(jcganjingid(k),noiseindex2)==1
        FN=FN+1;
    end
    if ismember(jcganjingid(k),ganjingid)==1
        TN=TN+1;
    end                
end   
precision1=TP/(TP+FP);
recall1=TP/(TP+FN);
specifity1=TN/(TN+FP);
F1score=2*precision1*recall1/(precision1+recall1);
Gmeans=sqrt(specifity1*recall1);
GandF6(7,1)=F1score;
GandF6(7,2)=Gmeans;
end
