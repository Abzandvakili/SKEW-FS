function [CovF_Class]=CovFClass(Featurs,Targets)
[~ , NumberOfFeatures] = size(Featurs);
CovF_C=zeros(NumberOfFeatures,1);
for i=1:NumberOfFeatures
    CovF_C1=cov(Featurs(:,i),Targets);
    CovF_C(i)=abs(CovF_C1(1,2));
end
CovF_Class = CovF_C;
end
