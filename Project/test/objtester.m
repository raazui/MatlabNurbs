clc; clear all;close all;
% Test Script for PSO objective function:
spheredemo;
% surfacedemo
obj = 'objective'; % Implicit call to the objetive function.
np = 1; % Population Size
%% Initialize the objective function:
costfun = str2func(obj); % Converts the string into a function handle.
%% Population Generation:
% Variables for generating population elements:
% Dimensionality of the problem:
Q = points(1:169,:); % [Nx3] point cloud. 
N = size(Q,1);
m = 13; % Size of the control point grid in the ith direction
n = 13; % Size of the control point grid in the jth direction
k = 3; % Maximum curve order for U
l = 3; % Maximum curve order for V
p = 100; % Size of point cloud data generated for error calculation (aplha)
q = 100; % Size of point cloud data generated for error calculation (beta)
nm = m*n; % Number of control points
orderk = [2 6]; % Min Max order possible for U
orderl = [2 6]; % Min Max order possible for V
% Puv(:,:,i) = param(Points,tmat(:,:,i),[]); 
% Population vector format:
% P = [P(x,y,z,w) S T];
for i = 1 : np
    % Generate weight vector for each Point in range [0,2]:
    P(:,4,i) = ones(nm,1);%2*rand(nm,1);
    % Randomly Sample Control Points from Q:
    temp = indexer(Q,nm);
    P(:,1:3,i) = temp;%indexer(Q,nm);
end
% P = sortrows(P(:,:,1));
for i = 1 : np
    % Generate U:
    U(:,i) = linspace(0,1,m)';
    Up(:,i) = linspace(0,1,p)';
    % Generate V:
    V(:,i) = linspace(0,1,n)';
    Vq(:,i) = linspace(0,1,q)';
end
for i = 1 : np
    % Generate knot vector for U:
    ikS(:,i) = ikgen(m,k)';
    S(:,i) = knotgen(ikS(:,i)',k);
    % Generate knot vector for V:
    ikT(:,i) = ikgen(n,l)';
    T(:,i) = knotgen(ikT(:,i)',l); 
end
% S(2) = 0.5*S(4);
% S(3) = S(4);
% T(2) = 0.5*T(4);
% T(3) = T(4);
% Objective function starts here:
%% Construct Surface:
% First we need to convert the control points into a matrix of size [nxm]:
% for pop = 2 : 1
pop = 1;
    Surface(:,:,:) = surfacegen(S(:,pop),T(:,pop),Up(:,pop),Vq(:,pop),...
        P(:,:,pop),m,n,k,l);
% end
% Plot the surface
% Plot Point Cloud Data:
figure(1);
hold on;
% error = objective(Q,ikS(:,1)',ikT(:,1)',Up(:,1),Vq(:,1),P(:,:,1),m,n,k,l);
% Plot Generated Surface Points:
for i = 1 : 1
    plot3(P(:,1,i),P(:,2,i),P(:,3,i),'b.');
    plot3(Surface(:,:,1,i),Surface(:,:,2,i),Surface(:,:,3,i),'r.');
end
