clc;
clear;
close all;

%% Data set
tic
load('abalone_dataset_c.mat');
Featurs = data(:,1:end-1);
Targets = data(:,end);

for h = 1:10
    data=[Featurs Targets];
    [~ , NumberOfFeatures] = size(Featurs);
    
    %% Correlation between Features
    
    Correlation_F = Corr_F(Featurs);
    
    %% Correlation between Features and class
    
    Correlation_F_C = zeros(NumberOfFeatures,1);
    for i=1:NumberOfFeatures
        Correlation_F_C(i) = Corr_F_C(data,i);
    end
    
    %% Rank
    
    Rank_Features = Rank_F(NumberOfFeatures,Correlation_F,Correlation_F_C);  
    [sort_R, Psort_R] = sort(Rank_Features);
    
    %% Shift Matrix
    
    [Shift_Matrix,PShift_Matrix] = Shift_F_R(Rank_Features, NumberOfFeatures);
  
    %% Select Features
    ou{h} = Select_F(Shift_Matrix,PShift_Matrix,NumberOfFeatures,data);
    Featurs = sortrows(Featurs',randi([1,NumberOfFeatures]));
    Featurs = Featurs';
    Featurs = fliplr(Featurs);

end
[Sort_Z, PSort_Z] = sort([ou{1,1}.z,ou{1,2}.z,ou{1,3}.z,ou{1,4}.z,ou{1,5}.z,ou{1,6}.z,ou{1,7}.z,ou{1,8}.z,ou{1,9}.z,ou{1,10}.z]);
for i=1:10
   disp(['Z1 = ',num2str(ou{1,PSort_Z(i)}.z1), '    Z2 = ',num2str(ou{1,PSort_Z(i)}.z2),'    Z3 = ',num2str(ou{1,PSort_Z(i)}.z3),'     Z = ',num2str(ou{1,PSort_Z(i)}.z)]);
   disp(['   MIN-features = ',num2str(ou{1,PSort_Z(i)}.nf)]);
   disp(['  ']);
end
disp(['     Time=',num2str(toc)]);




