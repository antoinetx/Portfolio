function [F1_overall, P, R, F1] =  f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (1 x M),  M-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (1 x M),  M-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = size(class_labels,2);

nClasses = max(class_labels);
nClusters = max(cluster_labels);

P = zeros(nClusters,nClasses);
R = zeros(nClusters,nClasses);
F1 = zeros(nClusters,nClasses);
F1_overall = 0;


for k = 1:nClusters
    
    x_k = find(cluster_labels == k);
    norm_k = size(x_k,2); % nb of data in cluster k
    
    for i = 1:nClasses
        c_i =  size(find(class_labels == i),2); % Nb of class i 
        n_ik = 0;
        for m = 1:M
            if (class_labels(m) == i & cluster_labels(m) == k)
                n_ik = n_ik + 1; %Nb of class i in cluster k
            end
        end
       
        R(k,i) = n_ik/c_i;
        
        P(k,i) = n_ik/norm_k;
        
        if(R(k,i)==0 | P(k,i)==0)
            F1(k,i) = 0;
        else
            F1(k,i) = (2*R(k,i)*P(k,i))/(R(k,i)+P(k,i));
        end
       
    end
end


for i = 1:nClasses
    
        c_i =  size(find(class_labels == i),2); % Nb of class i 
        
        F1_overall = F1_overall + (c_i/M)*max(F1(:,i));
end

end
