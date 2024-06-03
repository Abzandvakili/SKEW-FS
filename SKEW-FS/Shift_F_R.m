function [Shift_Matrix, PShift_Matrix]= Shift_F_R(Rank_Features, NumberOfFeatures)
F_R = Rank_Features;
Shift_M = zeros(NumberOfFeatures,NumberOfFeatures);
for i = 1 : NumberOfFeatures/5
    Shift_M(i,:) = circshift(F_R,1);
    F_R = Shift_M(i,:);
end
for j = 2 : NumberOfFeatures
    for k = 1 : NumberOfFeatures
        for p = k : NumberOfFeatures
            Shift_M(k,p) = inf;
        end
    end
end

Shift_Matrix = Shift_M;
[Shift_Matrix, PShift_Matrix] = sortrows(Shift_Matrix);

end