function [ pred ] = myregression( trainX, testX, noutput )
%MYREGRESSION Regresses on training data to predict test data

%Initializing values for use later in the function.
[N,n] = size(trainX);
[u,v] = size(testX);
X = trainX(:,1:n-noutput);
mu = mean(X);
sig = std(X);
NX = bsxfun(@rdivide,bsxfun(@minus,X,mu),sig);
T = trainX(:,n-noutput+1:n);
bestPhi = X;
minse = Inf;
tX = bsxfun(@rdivide,bsxfun(@minus,testX,mu),sig);
lamda=0;

PHI = [NX ones(N,1)];
mse = crossvalidate ( PHI, T, lamda );
if ( mse < minse )
    minse = mse;
    bestPhi = PHI;
    tX = [tX ones(u,1)];
end

for s = 10:10:100
    for nm = 100:100:500
        muj = fix(1 + (N-1)*rand([nm, 1]));
        PHI = gauss(X,muj,s);
        mse = crossvalidate ( PHI, T, lamda );
        if ( mse < minse )
            minse = mse
            bestPhi = PHI;
            tX = gauss(testX,nm,s);
        end
        
    end
end

pred = predict (bestPhi, T, lamda, tX);

    function [pred] = predict ( phi, t, lamda, test )
        pred = test * myregress(phi,t,lamda);
    end

    function [ w ] = myregress ( phi, t, lamda)
        I = eye(size(phi.'*phi));
        w = pinv(lamda*I + phi.'*phi)*phi.'*t;
    end

    %GAUSS Should return a phi based on gaussian basis functions
    function [phi] = gauss( x, mj, s )
        nx = bsxfun(@rdivide,bsxfun(@minus,x,mu),sig);
        [o,p] = size(nx);
        [h,g] = size(mj);
        phi = zeros([o,h]);
        for i = 1 : o
            for j = 1 : h
                m =  -(norm(nx(i)-NX(mj(j)))^2) / (2*s^2) ;
                phi(i,j) = exp(m);
            end
        end
    end

    function [mse] = crossvalidate (phi, t, lamda)
        [nr,nc] = size(phi);
        
        for cv = 1:5, % random cross validation
            cvindex = randperm(nr); % randomly permutes indices of data used for cv
            
            trainx = phi(cvindex(1:floor(nr*4/5)),:);
            traint = t(cvindex(1:floor(nr*4/5)),:);
            testx = phi(cvindex(ceil(nr*4/5):end),:);
            testt = t(cvindex(ceil(nr*4/5):end),:);
            
            predicted = predict(trainx, traint, lamda,testx);
            sqerr(cv) = sum((testt(:)-predicted(:)).^2);
        end;
        mse = mean(sqerr);
        
    end
end
