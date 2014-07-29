% Surface generation:
% Input:
% P - [mnx4] matrix of control points with values [x,y,z,w]
% K - order of the nurbs curve generated from u
% L - order of the nurbs curve generated from v
% u - parameter values for U dir
% v - parameter values for V dir
% m - number of control points in U dir
% n - number of control points in V dir
% Output:
% S - [u x v x 3] matrix containing the x,y,z location of the surface 
function Surface = surfacegen(S,T,U,V,P,m,n,k,l)
wij = vec2mat(P(:,4),m,n);
Pij = reshape(P(:,1:3),m,n,3);
for u=1:size(U,1)
    for v=1:size(V,1)
        Nk = basisgen(S,k,U(u)); % Find the basis functions for U     
        Nl = basisgen(T,l,V(v)); % Find the basis functions for V
        val = wij .* (Nk'*Nl);
        % Calculate the numerator
        den = sum( sum( val(:,:,1) ) ); % Calculate the denominator
        if den == 0
            R(:,:,:) =zeros(size(Pij));
        else
            % Create the Surface reconstruction matrix
            R(:,:,1) = ( val(:,:).*Pij(:,:,1) ) ./ den; 
            R(:,:,2) = ( val(:,:).*Pij(:,:,2) ) ./ den;
            R(:,:,3) = ( val(:,:).*Pij(:,:,3) ) ./ den;
        end

        Surface(u,v,1) = sum( sum( R(:,:,1) ) );
        Surface(u,v,2) = sum( sum( R(:,:,2) ) );
        Surface(u,v,3) = sum( sum( R(:,:,3) ) );
    end
end