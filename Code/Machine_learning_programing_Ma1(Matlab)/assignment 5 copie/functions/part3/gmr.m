function [y_est, var_est] = gmr(Priors, Mu, Sigma, X, in, out)
%GMR This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM) for a D-dimensional dataset,
% for D= N+P, where N is the dimensionality of the inputs and P the 
% dimensionality of the outputs.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o X:       N x M array representing M datapoints of N dimensions.
%   o in:      1 x N array representing the dimensions of the GMM parameters
%                to consider as inputs.
%   o out:     1 x P array representing the dimensions of the GMM parameters
%                to consider as outputs. 
% Outputs ----------------------------------------------------------------
%   o y_est:     P x M array representing the retrieved M datapoints of 
%                P dimensions, i.e. expected means.
%   o var_est:   P x P x M array representing the M expected covariance 
%                matrices retrieved. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




K = size(Priors,2);
P = size(out,2);
[N,M] = size(X);

y_est = zeros(P,M);
first_var = zeros(1,M);


for k=1:K
    num_beta(k,:) = Priors(1,k).*gaussPDF(X, Mu(1:N,k), Sigma(1:N,1:N,k));
    Mu_tilde(k,:) = Mu(N+1:N+P,k).*ones(1,M) + Sigma(N+1:N+P, 1:N, k)/Sigma(1:N,1:N,k)*(X-Mu(1:N,k).*ones(1,M));
    Sigma_tilde(k,:) = Sigma(N+1:N+P,N+1:N+P,k)-Sigma(N+1:N+P, 1:N, k)/Sigma(1:N,1:N,k)*Sigma(1:N, N+1:N+P,k);
end
beta = num_beta./sum(num_beta,1);

for k = 1:K
    
    y_est = y_est + beta(k,:).*Mu_tilde(k,:);
    first_var = first_var + beta(k,:).*(Mu_tilde(k,:).^2 + Sigma_tilde(k,:));
end

var_est = first_var - (y_est).^2;









end

