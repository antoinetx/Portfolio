function [F1_curve] =  f1measure_eval(X, K_range, repeats, init, type, MaxIter, true_labels)
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
%       o true_labels : (1 x M) the real labels for the F1 measure
%                       computation
%
%   output ----------------------------------------------------------------
%       o F1_curve   : (1 X K_range), F1 values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N,M] = size(X);
K = size(K_range,2);
plot_iter = false;

for k = 1:K
    Mu = zeros(N, k);
    labels = zeros(1,M);
    
    for i = 1:repeats % Compute the K-mean "repeats" time
        
        [labels, ~ , ~ , ~ ] =  kmeans(X,k,init,type,MaxIter,plot_iter);
        
        [F1_overall(i), ~ , ~ , ~ ] =  f1measure(labels, true_labels);
        
    end 
   
    % Compute the mean of the metrics
    F1_curve(k) = mean(F1_overall);
    
end





end