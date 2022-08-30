function [C] =  confusion_matrix(y_test, y_est)
%CONFUSION_MATRIX Implementation of confusion matrix 
%   for classification results.
%   input -----------------------------------------------------------------
%
%       o y_test    : (1 x M), a vector with true labels y \in {1,2} 
%                        corresponding to X_test.
%       o y_est     : (1 x M), a vector with estimated labels y \in {1,2} 
%                        corresponding to X_test.
%
%   output ----------------------------------------------------------------
%       o C          : (2 x 2), 2x2 matrix of |TP & FN|
%                                             |FP & TN|.
%
%   where positive is encoded by the label 1 and negative is encoded by the label 2.        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TP = size(find(y_test == 1 & y_est == 1),2);
TN = size(find(y_test == 2 & y_est == 2),2);
FP = size(find(y_test == 2 & y_est == 1),2);
FN = size(find(y_test == 1 & y_est == 2),2);

C(1,1) = TP;
C(1,2) = FN;
C(2,1) = FP;
C(2,2) = TN;

end

