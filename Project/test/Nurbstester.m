% Nurbs Tester:
% This script is meant to test the functionality of the Nurbs functions:
% basisgen.m (Generates B-spline basis functions)
% knotgen.m (Generates Non-uniform non periodic knots.
% surfacegen.m (Generates a surface S(u,v)
clc; clear all; close all;
%% Simple Nurbs Curve:
Points = [ 0 1.5 ; 1 2.6 ; 2 3 ; 3 2 ;2 1]; % Points on a curve
m = 5; % Number of Control points
k = 2; % Curve order - 1
t = linspace(0,1,m); % Parameter for curve
t1 = linspace(0,1,50); % Parameter for generating points
iks = ikgen(m,k);
knot = knotgen(iks,k);
for i = 1: numel(t1)
    Nk(i,:) = basisgen( knot , k,  t1(i) );
    C(i,1) = sum( ( Points(:,1) .* Nk(i,:)' ) ./ sum( Nk(i,:) ) );
    C(i,2) = sum( ( Points(:,2) .* Nk(i,:)' ) ./ sum( Nk(i,:) ) );
end
C1 = C(:,1);
C2 = C(:,2);
C1 = C1(isfinite(C1));
C2 = C2(isfinite(C2));
figure(1);
hold on;
plot(Points(:,1),Points(:,2),'rO');
plot(Points(:,1),Points(:,2),'r-');
plot(C1(:),C2(:),'b');
grid on;
hold off;
figure(2);
hold on;
color = hsv(size(Nk,2));
for i = 1 : size(Nk,2)
plot(Nk(:,i),'Color',color(i,:));
label(i,:) = ['Basis Function: ' num2str(i)];
end
hold off;
legend(label)