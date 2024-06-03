function CovFeatures_Class=Corr_F_C(data,i)

Featurs = data(:,i);
Targets = data(:,end);
%% corr(a',b','type','Pearson')

CovFeatures_Class = abs(corr(Featurs,Targets,'type','Pearson'));
end
