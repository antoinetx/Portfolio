function [ Sigma ] = compute_covariance( X, X_bar, type )
%MY_COVARIANCE computes the covariance matrix of X given a covariance type.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o X_bar : (N x 1), an Nx1 matrix corresponding to mean of data X
%       o type  : string , type={'full', 'diag', 'iso'} of Covariance matrix
%
% Outputs ----------------------------------------------------------------
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix of the 
%                          Gaussian function
%%

[N,M] =  size(X);


switch type
    
    case 'full'
        X_mean = X-X_bar;
        Sigma =  (1/(M-1)) * X_mean*X_mean'; 
        
    case 'diag'
        X_mean = X-X_bar;
        Sigma_full =  (1/(M-1)) * X_mean*X_mean'; 
        Sigma = diag(diag(Sigma_full));
        
    case 'iso'
        for i = 1:M
            inner_sum(i) = norm(X(:,i) - X_bar)^2;
        end
        
        var_iso = (1/(N*M))* sum(inner_sum);
        
        % Return a full matrix of var_iso and then take its diag 
        Sigma = var_iso * ones(N);
        Sigma = diag(diag(Sigma));
end
end

