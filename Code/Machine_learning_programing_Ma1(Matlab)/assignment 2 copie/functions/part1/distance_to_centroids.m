function [d] =  distance_to_centroids(X, Mu, type)
%MY_DISTX2Mu Computes the distance between X and Mu.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o Mu    : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N
%       o type  : (string), type of distance {'L1','L2','LInf'}
%
%   output ----------------------------------------------------------------
%
%       o d      : (k x M), distances between X and Mu 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N, k] = size(Mu);
[N, M] = size(X);

if (type == "L1")
    for i = 1:k
        d(i,:) = sum(abs(X - Mu(:,i)));
    end
   
elseif (type == "L2")
     for i = 1:k
        d(i,:) = sqrt(sum((X - Mu(:,i)).^2));
    end
    
elseif (type == "LInf")
     for i = 1:k
        d(i,:) = max(abs(X - Mu(:,i)));
    end
   
end

end