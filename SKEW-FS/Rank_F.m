function [Rank_Features] = Rank_F(NumberOfFeatures,Correlation_F,Correlation_F_C)

Rank_Features = zeros(1,NumberOfFeatures);
for j=1:NumberOfFeatures
    if j==1
        mean_f1 = mean(Correlation_F(1,:));
        Rank_Features(j) = Correlation_F_C (j) / (mean_f1 + Correlation_F(j,j+1));
    elseif j==NumberOfFeatures
        mean_fN = mean(Correlation_F(NumberOfFeatures,:));
        Rank_Features(j) = Correlation_F_C (j) / (mean_fN + Correlation_F(j,j-1));
    else
        Rank_Features(j) = Correlation_F_C (j) / (Correlation_F(j,j-1) + Correlation_F(j,j+1));
    end
    %     if Rank_Features(j)< 0.000001
    %         Rank_Features(j) = 0;
    %     end
end
% Max_R = max(Rank_Features);
% Min_R = min(Rank_Features);
[sort_R, ~] = sort(Rank_Features);
Median_R  = median(sort_R);
MedianL_R = median(sort_R(1:NumberOfFeatures/2));
MedianR_R = median(sort_R(NumberOfFeatures/2:NumberOfFeatures));

for k=1:NumberOfFeatures
    if Rank_Features(k) <= MedianL_R
        Rank_Features(k) = 4;
    elseif Rank_Features(k) >= MedianL_R && Rank_Features(k) <= Median_R
        Rank_Features(k) = 3;
    elseif Rank_Features(k) >= Median_R && Rank_Features(k) <= MedianR_R
        Rank_Features(k) = 2;
    elseif Rank_Features(k) >= MedianR_R 
        Rank_Features(k) = 1;
    end
end
    
end
