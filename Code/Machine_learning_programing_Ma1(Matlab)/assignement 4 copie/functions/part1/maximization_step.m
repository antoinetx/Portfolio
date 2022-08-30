function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
%MAXIMISATION_STEP Compute the maximization step of the EM algorithm
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
%                     that a k Gaussian is responsible for generating a point
%                     m in the dataset, output of the expectation step
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
%                     and cov_type the coviariance type
%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%
% Initialisation
[N,M] = size(X);

% Prios computation
Priors = (1/M) * sum(Pk_x,2);
Priors = Priors';

% Sigma and Mu computation
e = 1.e-5;
e_mat = eye(N) .* e;

for k = 1:params.k
    
    % Mu computation
    Mu(:,k) = sum(X .* Pk_x(k,:),2) ./ sum(Pk_x(k,:),2);
    
    % Sigma computation
    switch params.cov_type
        case 'full'
            
            Sigma(:,:,k) = (((X - Mu(:,k)).* Pk_x(k,:)) * (X - Mu(:,k))') ./ sum(Pk_x(k,:),2);
            Sigma(:,:,k) = Sigma(:,:,k) + e_mat;
            
        case 'diag'
            
            Sigma(:,:,k) = diag(diag((((X - Mu(:,k)).* Pk_x(k,:)) * (X - Mu(:,k))') ./ sum(Pk_x(k,:),2)));
            Sigma(:,:,k) = Sigma(:,:,k) + e_mat;
            
        case 'iso'
            
            iso =(Pk_x(k,:) * (vecnorm(X - Mu(:,k)).^2)') / (N * sum(Pk_x(k,:),2));
            Sigma(:,:,k) = diag(ones(N,1).*iso);
            Sigma(:,:,k) = Sigma(:,:,k) + e_mat;
    end
    
end

end

