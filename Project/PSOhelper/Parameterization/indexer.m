% Function Indexer:
% Randomly samples a target vector (vec1) to select N values to construct
% another vector of size [Nx1].
% Inputs:
% vec1 - [Dxn] target vector
% N - desired length of new vector
% vec2 - [Nxn] destination vector
function vec2 = indexer(vec1,N)
% Array containing the indecies of vec1:
indexes1 = size(vec1,1);
% Shuffles indices in vec1:
indexes2 = randperm(indexes1,N);
% Stores values from vec1 into vec2 acoording to the shuffled indices:
vec2 = vec1(indexes2,:);

    
