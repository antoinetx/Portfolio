function [metrics] = cross_validation_gmr( X, y, F_fold, valid_ratio, k_range, params )
%CROSS_VALIDATION_GMR Implementation of F-fold cross-validation for regression algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (P x M) array representing the y vector assigned to
%                           each datapoints
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Testing Ratio.
%       o k_range   : (1 x K), Range of k-values to evaluate
%       o params    : parameter strcuture of the GMM
%
%   output ----------------------------------------------------------------
%       o metrics : (structure) contains the following elements:
%           - mean_MSE   : (1 x K), Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_NMSE  : (1 x K), Normalized Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_R2    : (1 x K), Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - mean_AIC   : (1 x K), Mean AIC Scores computed for each value of k averaged over the number of folds.
%           - mean_BIC   : (1 x K), Mean BIC Scores computed for each value of k averaged over the number of folds.
%           - std_MSE    : (1 x K), Standard Deviation of Mean Squared Error computed for each value of k.
%           - std_NMSE   : (1 x K), Standard Deviation of Normalized Mean Squared Error computed for each value of k.
%           - std_R2     : (1 x K), Standard Deviation of Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - std_AIC    : (1 x K), Standard Deviation of AIC Scores computed for each value of k averaged over the number of folds.
%           - std_BIC    : (1 x K), Standard Deviation of BIC Scores computed for each value of k averaged over the number of folds.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[P,N] = size(y);
K = size(k_range,2);

for k = 1:K
    
    params.k = k_range(k);
    
    for i = 1:F_fold
        
        % Split data
        [X_train, y_train, X_test, y_test] = split_regression_data(X, y, valid_ratio);

        % gmm and gmr computation
        [ Priors, Mu, Sigma, ~ ] = gmmEM([X_train ; y_train], params);
        [yest, ~] = gmr(Priors, Mu, Sigma, X_test, (1:N), (N+1:(N+P)));

        [AIC(1,i), BIC(1,i)]= gmm_metrics([X_train ; y_train], Priors, Mu, Sigma, params.cov_type);
        [MSE(1,i), NMSE(1,i), R2(1,i)] = regression_metrics(yest, y_test);
    end

    % Save the values in output parameters
    metrics.mean_MSE(:,k) = mean(MSE,2);
    metrics.mean_NMSE(:,k) = mean(NMSE,2);
    metrics.mean_R2(:,k) = mean(R2,2);
    metrics.mean_AIC(:,k) = mean(AIC,2);
    metrics.mean_BIC(:,k) = mean(BIC,2);
    metrics.std_MSE(:,k) = std(MSE);
    metrics.std_NMSE(:,k) = std(NMSE);
    metrics.std_R2(:,k) = std(R2);
    metrics.std_AIC(:,k) = std(AIC);
    metrics.std_BIC(:,k) = std(BIC);
end

end

