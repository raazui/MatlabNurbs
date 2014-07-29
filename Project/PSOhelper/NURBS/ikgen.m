% Internal Knot Generation:
% Inputs:
% m     : Number of control points
% k     : order of curve
% Output:
% ik    : vector of internal knots of size [(m+k)-2k x 1 ]
function ik = ikgen(m,k)
len = m - k + 1;
ik = sort( rand(1,len) );
