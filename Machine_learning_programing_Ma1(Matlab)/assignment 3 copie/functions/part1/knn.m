function [ y_est ] =  knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k, d_type)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[N,M] = size(X_train);
M_test = size(X_test,2);
C = max(y_train);
y_est = zeros (M_test,1);
K = params.k;

% For each testing point, compute the distance with all trainning points
for i = 1:M_test
    d_i = zeros(1,M);
    y_knn = zeros(1,K);
    % For each testing point, compute the distance with all trainning points
    for j = 1:M
        d_i(1,j) = compute_distance(X_test(:,i), X_train(:,j),params);
    end
    
    [di_sorted, idx_sorted] = sort(d_i,'ascend');
    idx_sorted_k = idx_sorted(1:K);
    y_knn(1,:) = y_train(1,idx_sorted_k);
        
     y_prime = zeros(1,C);
     
     for c = 1:C 
         y_prime(1,c) =  size(find(y_knn(1,:) == c),2);
     end
     
     [ ~, y_est(i)] = max(y_prime);
     
end

y_est = y_est';



end