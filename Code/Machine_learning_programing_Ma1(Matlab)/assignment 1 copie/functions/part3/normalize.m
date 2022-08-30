function [X, param1, param2] = normalize(data, normalization, param1, param2)
%NORMALIZE Normalize the data wrt to the normalization technique passed in
%parameter. If param1 and param2 are given, use them during the
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o data : (N x M), a dataset of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : (optional) first parameter of the normalization to be
%                  used instead of being recalculated if provided
%       o param2 : (optional) second parameter of the normalization to be
%                  used instead of being recalculated if provided
%
%   output ----------------------------------------------------------------
%
%       o X : (N x M), normalized data
%       o param1 : first parameter of the normalization
%       o param2 : second parameter of the normalization

switch nargin
    case 2 %if we got only 2 parameters
        
        if (normalization == "minmax")
            param1 = min(data,[],2);
            param2 = max(data,[],2);
            X = (data - param1)./(param2 - param1);
        elseif (normalization == "zscore")
            param1 = mean(data,2);
            param2 = std(data,0,2);
            X = (data - param1) ./ param2; %X = (data - mean(data,2)) ./ std(data,0,2);
        elseif (normalization == "none")
            X = data;
            param1 = 0;
            param2 = 0;
        else
            error_message = "Wrong input argument for 'normalisation'"
            X = data;
            param1 = 0;
            param2 = 0;
        end

        
    case 3 %if we got only 3 parameters
        if (normalization == "minmax")
            param2 = max(data,[],2);
            X = (data - param1)./(param2 - param1);
        elseif (normalization == "zscore")
            param2 = std(data,0,2);
            X = (data - param1) ./ param2;
        elseif (normalization == "none")
            X = data;
            param1 = 0;
            param2 = 0;
        else
            error_message = "Wrong input argument for 'normalisation'"
            X = data;
            param1 = 0;
            param2 = 0;
        end
        
    case 4 %if we got the 4 parameters
        if (normalization == "minmax")
            X = (data - param1)./(param2 - param1);
        elseif (normalization == "zscore")
            X = (data - param1) ./ param2;
        elseif (normalization == "none")
            X = data;
            param1 = 0;
            param2 = 0;
        else
            error_message = "Wrong input argument for 'normalisation'"
            X = data;
            param1 = 0;
            param2 = 0;
        end
        
    otherwise 
        X = data;
        param1 = 0;
        param2 = 0;
        
end


end

