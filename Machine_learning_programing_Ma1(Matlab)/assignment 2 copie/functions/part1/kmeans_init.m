function [Mu] =  kmeans_init(X, k, init)
%KMEANS_INIT This function computes the initial values of the centroids
%   for k-means algorithm, depending on the chosen method.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o k     : (double), chosen k clusters
%       o init  : (string), type of initialization {'sample','range'}
%
%   output ----------------------------------------------------------------
%
%       o Mu    : (D x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N                   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N, M] = size(X);

column = 1;
row = 2;

if (init == "sample")
    
    Mu = datasample(X,k,row);
    
elseif (init == "range")
    
    % return the min and max of the dimension 2 (the lines) of x.
    min_x =  min(X,[],row);
    max_x =  max(X,[],row);
   
    % for eatch data it return a random value between the min and the max
    % of those data.
    
    range = abs(max_x - min_x); % Compute the range of point in wich centroïds can be initialized
    
    Mu = min_x + range.*rand(N,k); 
    
end

end