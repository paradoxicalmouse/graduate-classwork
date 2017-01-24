function [ prediction, bestk, errors ] = myKNN( X, Y, Xtest, k)
%myKNN uses cross validation approach to determine best value for k
%   Detailed explanation goes here
    
    classes = max(Y);
    [m, ~]  = size (X);
    [ks, ~] = size (k);
    errors = zeros(ks,1);
    for ki = 1 : ks
        errors(ki) = leaveOneOut(X, Y, k(ki));
    end
    [~,bk] = min(errors);
    bestk = k(bk);
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
        neighbors = findNearestNeighbors( x, X, Y, k );
        kClass = zeros(classes,1);
        for neighbor = 1 : k
            kClass(neighbors(neighbor)) = kClass(neighbors(neighbor)) + 1;
        end
        kClass = kClass ./ k;
        [~, prediction] = max(kClass);
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
       neighbors = distances(:,2);
    end


end

