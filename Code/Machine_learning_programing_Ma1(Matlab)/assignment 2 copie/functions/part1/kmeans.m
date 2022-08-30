function [labels, Mu, Mu_init, iter] =  kmeans(X,K,init,type,MaxIter,plot_iter)
%MY_KMEANS Implementation of the k-means algorithm
%   for clustering.
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'sample','range'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations
%       o plot_iter: (bool), boolean to plot iterations or not (only works with 2d)
%
%   output ----------------------------------------------------------------
%
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters for each points.
%       o Mu       : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N 
%       o Mu_init  : (N x k), same as above, corresponds to the centroids used
%                            to initialize the algorithm
%       o iter     : (int), iteration where algorithm stopped
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TEMPLATE CODE (DO NOT MODIFY)
% Auxiliary Variable
[D, N] = size(X);
d_i    = zeros(K,N);
k_i    = zeros(1,N);
r_i    = zeros(K,N);
if plot_iter == [];plot_iter = 0;end
tolerance = 1e-6;
MaxTolIter = 10;

% Output Variables
Mu     = zeros(D, K);
labels = zeros(1,N);


%% INITIALISATION (INSERT CODE HERE)

Mu_init = kmeans_init(X, K, init);
Mu = Mu_init;
iter = 0;
has_converged = false;
tol_iter = 0;

%% TEMPLATE CODE (DO NOT MODIFY)
% Visualize Initial Centroids if N=2 and plot_iter active
colors     = hsv(K);
if (D==2 && plot_iter)
    options.title       = sprintf('Initial Mu with %s method', init);
    ml_plot_data(X',options); hold on;
    ml_plot_centroids(Mu_init',colors);
end


%% KMEAN COMUTING (INSERT CODE HERE)

while (has_converged == false)
    
    iter = iter + 1;
   
    r_i = zeros(K,N);
    
    d_i = distance_to_centroids(X, Mu, type);
    
    % Si data point aussi loin que 2 centroides assigner le centroide avec smallest winning cluster size 
    
    min_di = d_i(1,:);
    k_i(:) = 1;
    
    for i = 1:N
        for k = 1:K
            if min_di(i) > d_i(k,i)
                min_di(i) = d_i(k,i);
                k_i(i) = k;
            elseif min_di(i) == d_i(k,i)
                if size(find(k_i(:) == k),1) <= size(find(k_i(:) == k_i(i)),1)
                    min_di(i) = d_i(k,i);
                    k_i(i) = k;
                end
            end
        end
    end
    
   
    
    labels = k_i;
    
    for (i = 1:N)
        r_i(k_i(i),i) = 1;
    end 

    
    
    Mu_previous = Mu;
    
    sum_i = sum(r_i,2);
    
    for (i = 1:K)
        if  (sum_i(i) == 0)
            Mu_init = kmeans_init(X, K, init);
            iter = 0;
            Mu = Mu_init;
            break
        else 
            Mu = ((r_i*X')./sum(r_i,2))';
        end
    end 
    
    [has_converged, tol_iter] = check_convergence(Mu,Mu_previous,iter,tol_iter,MaxIter,MaxTolIter,tolerance);
    
   
end
%}

%% TEMPLATE CODE (DO NOT MODIFY)
if (D==2 && plot_iter)
    options.labels      = labels;
    options.class_names = {};
    options.title       = sprintf('Mu and labels after %d iter', iter);
    ml_plot_data(X',options); hold on;    
    ml_plot_centroids(Mu',colors);
end


end