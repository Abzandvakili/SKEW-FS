function results=CreateAndTrainTree(x,t)

if ~isempty(x)
    X=x;
    T=t;
    [r,~]=size(x);
    rr=randi([1 r],round(r*20/100),1);
    
    xtest=x(rr,:);
    ytest=t(rr,:);
    
    X(rr,:)=[];
    T(rr,:)=[];
    
    xtrain=X;
    ytrain=T;
        
    ctree = fitctree(xtrain,ytrain);
    %     view(ctree,'mode','graph');
    YnewTest  = predict(ctree,xtest);
    YnewTrain = predict(ctree,xtrain);
       
    % Calculate error Train
    ErrorTrain=(sum(sqrt((YnewTrain-ytrain).^2)))/100;
    
    % Calculate error  Test
    ErrorTest=(sum(sqrt((YnewTest-ytest).^2)))/100;
    
else
    
    ErrorTrain=0;
    ErrorTest=0;
end

results.ErrorTrain=ErrorTrain;
results.ErrorTest=ErrorTest;

end
