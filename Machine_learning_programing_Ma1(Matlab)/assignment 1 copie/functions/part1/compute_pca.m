function [Mu, C, EigenVectors, EigenValues] = compute_pca(X)
%COMPUTE_PCA Step-by-step implementation of Principal Component Analysis
%   In this function, the student should implement the Principal Component 
%   Algorithm
%
%   input -----------------------------------------------------------------
%   
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%
%   output ----------------------------------------------------------------
%
%       o Mu              : (N x 1), Mean Vector of Dataset
%       o C               : (N x N), Covariance matrix of the dataset
%       o EigenVectors    : (N x N), Eigenvectors of Covariance Matrix.
%       o EigenValues     : (N x 1), Eigenvalues of Covariance Matrix

%% Known data 

M = width(X);

%% Demean the Data

% the Mu(j) are the componant of the Mean vector E(x).
Mu = mean(X,2);

% Center the data :
X = X - Mu;

%% Covariance Matrix Computation

C = (1/(M-1)) * (X * X.');  %X.' is X transposed

%% Eigenvalue Value Decomposition

[EigenVectors,D] = eig(C);

% Sort the eigenvalues
[EigenValues,ind]= sort(diag(D),'descend');

% Sort the eigenvectors with the eigenvalues vector index
[EigenVectors] = EigenVectors(:,ind); 

