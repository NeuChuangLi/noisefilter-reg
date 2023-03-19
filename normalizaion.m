function [row,X,Y] = normalizaion(datasettable)


[row,column]=size(datasettable);

maxvalue=zeros(column,1);
minvalue=zeros(column,1);
for i=1:1:column
    maxid=find(max(datasettable(:,i))==datasettable(:,i));
    minid=find(min(datasettable(:,i))==datasettable(:,i));
    maxvalue(i)=datasettable(maxid(1),i);
    minvalue(i)=datasettable(minid(1),i);
end
for i=1:1:column
    datasettable(:,i)=(datasettable(:,i)-minvalue(i))./(maxvalue(i)-minvalue(i));
end

X=datasettable(:,1:1:column-1);
Y=datasettable(:,column);


end

