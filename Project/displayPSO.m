% Displays the surface created from the PSO:
function displayPSO(Q,ikS,ikT,Up,Vq,P,m,n,k,l)
Up = linspace(0,1,1000)';
Vq = linspace(0,1,1000)';
S = knotgen(ikS,k);
T = knotgen(ikT,l);
% Generate the knots:
S = knotgen(ikS,k);
T = knotgen(ikT,l);
% Calculate / Generate the surface:
Surface = surfacegen(S,T,Up,Vq,P,m,n,k,l);
Snew = reshape(Surface,size(Up,1)*size(Vq,1),3);
% Plot the surface:
figure(1),
hold on;
plot3(Q(:,1),Q(:,2),Q(:,3),'bO');
plot3(Snew(:,1),Snew(:,2),Snew(:,3),'rX');
