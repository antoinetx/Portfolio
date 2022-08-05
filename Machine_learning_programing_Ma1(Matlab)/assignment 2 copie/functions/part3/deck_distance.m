function [dist] = deck_distance(deck, Mu, type)
%DECK_DISTANCE Calculate the distance between a partially filled deck and
%the centroides
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N x 1) a partially filled deck
%       o Mu : (N x K) Value of the centroids
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o dist : K X 1 the distance to the k centroids
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create the subset where card are not 0
idx_without_0 = find(deck ~= 0);

deck_without_0 = deck(idx_without_0);
Mu_without_0 = Mu(idx_without_0,:);

[dist] =  distance_to_centroids(deck_without_0, Mu_without_0, type);


end

