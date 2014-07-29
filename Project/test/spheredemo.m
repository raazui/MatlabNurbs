clc; clear all; close all;
% Sphere Test:
% Reconstructs a sphere to test the PSO-NURBS surface reconstruction
% Algorithm:
%% Construct Sphere:
c = [0 0 0]; % Centriod
r = 1;
x = -4:0.1:4;
y = -4:0.1:4;
z = -4:0.1:4;
c = 1;
for i = 1 : numel(x)
    for j = 1 : numel(y)
        for k = 1 : numel(z)
            result = x(i)^2 + y(j)^2 + z(k)^2;
            diff = abs( r^2 - result );
            if diff < 0.01
                points(c,1) = x(i);
                points(c,2) = y(j);
                points(c,3) = z(k);
                c = c + 1;
            end
        end
    end
end
% plot3(points(:,1),points(:,2),points(:,3),'r.');
% p = size(points,1); % Number of points on the sphere surface.
%% Create Control Points:
