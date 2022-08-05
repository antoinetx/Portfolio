function [cr, compressedSize] = compression_rate(img,cimg,ApList,muList)
%COMPRESSION_RATE Calculate the compression rate based on the original
%image and all the necessary components to reconstruct the compressed image
%
%   input -----------------------------------------------------------------
%       o img : The original image   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o cr : The compression rate
%       o compressedSize : The size of the compressed elements

% Compute the number of bit necessary to store the matrix (compute the nb
% of element x 64 bits because each element is 64 bits)

s_Y = numel(cimg) * 64; 
s_Ap = numel(ApList) * 64;
s_Mu = numel(muList) * 64;
s_img = numel(img) * 64;

% Compute the size to store all the elements needed for reconstruction 
compressedSize = s_Y + s_Ap + s_Mu;

% Compute cr
cr = 1 - (compressedSize/s_img);

% Convert the size to megabits
compressedSize = compressedSize / 1048576; 
end

