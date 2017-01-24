function [prediction, bestlambda] = myWKNN(X, Y, Xtest)
    
    classes = max(Y);
    [m, ~]  = size (X);
    bestk = 29;
    errors = zeros(10,1);
    for lams = 1:20
        lam = lams/10;
        errors(lams) = leaveOneOut(X, Y, bestk);
    end
    [~,l] = min(errors);
    min(errors)
    lam = l/10;
    bestlambda = lam;
    [testSize,~] = size(Xtest);
    prediction = zeros(testSize,1);
    for t = 1 : testSize
        prediction(t) = classifyX( Xtest(t,:), X, Y, bestk);
    end
    
    
    function [ errors ] = leaveOneOut( X, Y, k )
       %leaveOneOut performs leave one out cross validation
       errors = 0;
       for i = 1 : m
          Z = X;
          Z(i,:) = [];
          W = Y;
          W(i,:) = [];
          pred = classifyX( X(i,:), Z, W, k);
          if pred ~= Y(i)
              errors = errors + 1;
          end
       end
    end
    
    function [ prediction ] = classifyX ( x, X, Y, k ) 
        %classifyX classifies the given X using k nearest neighbors
        nbs = findNearestNeighbors( x, X, Y, k );
        denom = 0;
        kC = zeros(classes,1);
        for nb = 1 : k
            weight = exp(-lam*nbs(nb,1)^2);
            kC(nbs(nb,2)) = kC(nbs(nb,2)) + weight;
            denom = denom + weight;
        end
        kC = kC ./ denom;
        [~, prediction] = max(kC);
    end

    function [ neighbors ] = findNearestNeighbors ( x, X, Y, k )
       %findNearestNeighbors finds the n nearest neighbors to a point, x
       %    from X
       distances = Inf(k, 2);
       for i = 1 : size(X)
           if size(x) ~= size(X(i,:))
               size(x)
               size(X(i,:))
           end
           dist = norm(x - X(i,:));
           for j = 1 : k
               if dist < distances(j,1)
                   distances(k,2) = Y(i);
                   distances(k,1) = dist;
                   distances = sortrows(distances,1);
                   break;
               end
           end
       end
       neighbors = distances;
    end

end