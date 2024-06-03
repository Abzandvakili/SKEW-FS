function ou = Select_F(Shift_Matrix,PShift_Matrix,NumberOfFeatures,data,CovF_Class)
min_z = inf;
for i = 1 : NumberOfFeatures/2
    S = zeros(1,NumberOfFeatures);
    Position_S_F  = PShift_Matrix(i);
    Position_S_F  = NumberOfFeatures - Position_S_F + 1;
    Number_of_S_F = numel(find(Shift_Matrix(i,:) ~= Inf));
    S(Position_S_F:Position_S_F + Number_of_S_F) = 1;
    [z, out] = FeatureSelectionCost(S,data);
    if z < min_z
        min_z = z;
        ou = out;
    end
end
end