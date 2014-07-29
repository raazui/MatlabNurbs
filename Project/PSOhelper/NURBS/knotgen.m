% clc;clear all;close all;
% Generates a non uniform non-periodic knot vector
% Inputs: 
% ik    : internal knots to be inserted [1x(m+k)-2k]
% order : order of the curve to generated.
% Output:
% knot  : Knot vector of size [rx1];

function knot = knotgen(ik,order)
k = order;
m = numel(ik) + k-1;
r = m + k;
% Beginning Knots:
u = zeros(1,r);
% Internal Knots:
count = 1;
for i = k + 1: r - k
    u(i) = ik(count);
    count = count + 1;
end
% End Knots:
u( ( r - k + 1 ) : end) = 1;
knot = u';