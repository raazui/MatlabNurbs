% Objective Function for PSnurbs:
function error = objective(Q,ikS,ikT,Up,Vq,P,m,n,k,l)
% Generate the knots:
S = knotgen(ikS,k);
T = knotgen(ikT,l);
% Calculate / Generate the surface:
Surface = surfacegen(S,T,Up,Vq,P,m,n,k,l);
Snew = reshape(Surface,size(Up,1)*size(Vq,1),3);
% size(Q)
% size(Snew)
error =sum( sum( ( Q - Snew ) .^2 ) );
 