function [MSE, NMSE, Rsquared] = regression_metrics( yest, y )
%REGRESSION_METRICS Computes the metrics (MSE, NMSE, R squared) for 
%   regression evaluation
%
%   input -----------------------------------------------------------------
%   
%       o yest  : (P x M), representing the estimated outputs of P-dimension
%       of the regressor corresponding to the M points of the dataset
%       o y     : (P x M), representing the M continuous labels of the M 
%       points. Each label has P dimensions.
%
%   output ----------------------------------------------------------------
%
%       o MSE       : (1 x 1), Mean Squared Error
%       o NMSE      : (1 x 1), Normalized Mean Squared Error
%       o Rsquared  : (1 x 1), Coefficent of determination
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = size(yest,2);

MSE = (1/M) * sum((yest - y).^2,2);

Mu = (1/M) * sum(y,2);
VAR = (1/(M-1)) * sum((y - Mu).^2,2);

NMSE = MSE/VAR;

y_av = mean(y);
yest_av = mean(yest,2);

num = (sum((y - y_av).*(yest - yest_av),2)).^2;
den = sum((y - y_av).^2,2) * sum((yest - yest_av).^2,2);
Rsquared = num/den;


end

