% clc; clear all; close all;
% Generates the B-Spline Basis Function for surface generation:
% t: parameter with value of either U or V:
% Order: Either value of k or l
% Index: (either i or j) containing the index count
% Knot: [r+1x1] Knot vector containing all relevant knots
% Follows the format:
% i = 1 | N(1,1)
% i = 2 | N(2,1) N(2,2)
% i = 3 | N(3,1) N(3,2) N(3,3)
% ....  | .....................
% i = m | N(m,1) N(m,2) N(m,3) .... N(m,order)
% Objective is to find the Diagonal of the matrix N.
function Nk = basisgen(knot,order,t)
% Calculate the number of control points in the desired dimension:
% Create a matrix for storing the values of size [mxorder]:
mplus = numel(knot) - order;
% N = zeros(mplus,order);
for i=1: numel(knot)-1 % Itterate to m+1 points
    % Generate linear basis functions:
    if ( knot(i) <= t ) && ( knot(i+1)> t )
        N(i,1) = 1;
    else
        N(i,1) = 0;
    end
end

% Find all non linear basis functions up till the spline degree:
k=2;
count = 1;
while ( k <= order + 1 ) 
    for i = 1 : mplus
        a = k;
        temp1 = ( ( t - knot(i) ) / ( knot(i+a-1) - knot(i) ) ) *...
            ( N(i,k-1) );
        if i<mplus
            temp2 = ( ( knot(i+a) - t ) / ( knot(i+a) - knot(i+1) ) ) *...
                ( N(i+1,k-1) );
        else
            temp2 =0;
        end
        temp = temp1 + temp2;
        % If the case is that the temp = (0/0) = 0
        if isfinite(temp)
            N(i,k) = temp;
        else
            N(i,k) = 0;
        end
        % Store if it is the last element in the row.
        if k == order && count<=mplus
            Nk(count) = N(i,k);
            if count == mplus
                Nk(1) = 1 - sum(Nk) ;
            end
            count = count + 1;
        end
    end
        k = k + 1;
end