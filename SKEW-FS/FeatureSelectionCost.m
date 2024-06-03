function [z, out]=FeatureSelectionCost(s,data)

% Read Data Elements
x = data(:,1:end-1);
t = data(:,end);

 [~,Number_Of_Feature]=size(x);

% Selected Features
S=find(s~=0);
% Number of Selected Features
nf=numel(S);
% Ratio of Selected Features
rf=nf/numel(s);
% Calculate redundancy
 sum_similar=0;
 xs=x(:,S);
 re_xs=xs;
for i=1:nf-1
    for j=i+1:nf
        cov_ij = corr(re_xs(:,i),re_xs(:,j));
        sum_similar = sum_similar + abs(cov_ij);
    end
end
q=nf*(nf-1)/2;
redundancy= sum_similar/q;
if (isinf(redundancy)|| isnan(redundancy))
    redundancy=10;
end
%% ANN
wTrain=0.8;
wTest=1-wTrain;

% Number of Runs
nRun=1;
EE=zeros(1,nRun);
for r=1:nRun  
    results = CreateAndTrainTree(xs,t) ; 
    % Calculate Overall Error
    EE(r) = wTrain*results.ErrorTrain + wTest*results.ErrorTest;
end

E=mean(EE);
if isinf(E)
    E=100;
end
%%
feature_proportion = nf/Number_Of_Feature;
% Calculate Final Cost
z1 = E/100;
z2 = feature_proportion;
z3 = redundancy;

w1=1/3;
w2=1/3;
w3=1/3;

z=w1*z1 + w2*z2 + w3*z3 ;

% Set Outputs
out.S=S;
out.nf=nf;
out.rf=rf;
out.E=E;
out.z=z;
out.z1=z1;
out.z2=z2;
out.z3=z3;

end
