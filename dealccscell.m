function [RMSEmatrix] = dealccscell(inputccscell,algorithm,percent)

RMSEmatrix=zeros(22,7);
for i=1:1:22
    RMSEmatrix(i,:)=inputccscell{i,percent}(algorithm,:);
end

end
