function [RSS_curve, AIC_curve, BIC_curve] =  kmeans_eval(X, K_range,  repeats, init, type, MaxIter)
%KMEANS_EVAL Implementation of the k-means evaluation with clustering
%metrics.
%
%   input -----------------------------------------------------------------
%   
%       o X           : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o repeats     : (1 X 1), # times to repeat k-means
%       o K_range     : (1 X K_range), Range of k-values to evaluate
%       o init        : (string), type of initialization {'sample','range'}
%       o type        : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter     : (int), maximum number of iterations
%
%   output ----------------------------------------------------------------
%       o RSS_curve  : (1 X K_range), RSS values for each value of K in K_range
%       o AIC_curve  : (1 X K_range), AIC values for each value of K in K_range
%       o BIC_curve  : (1 X K_range), BIC values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[N,M] = size(X);
K = size(K_range,2);
plot_iter = false;

for k = 1:K
    Mu = zeros(N, k);
    labels = zeros(1,M);
    
    for i = 1:repeats % Compute the K-mean "repeats" time
        
        [labels, Mu, ~ , ~ ] =  kmeans(X,k,init,type,MaxIter,plot_iter);
        
        [RSS_i(i), AIC_i(i), BIC_i(i)] =  compute_metrics(X, labels, Mu);
    end 
   
    % Compute the mean of the metrics
    RSS_curve(k) = mean(RSS_i);
    AIC_curve(k) = mean(AIC_i);
    BIC_curve(k) = mean(BIC_i);
    
end

end