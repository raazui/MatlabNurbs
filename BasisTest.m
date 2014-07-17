clc;clear all;close all;
% BasisTest.m
% Description: Testscript for Basis function.
% 1-D Test: B-spline curve
%% Initialize Test Variables:
ppoint = 0:0.02:1; % Contains 6 values.
ptsx = [0 2 4 5];
ptsy = [1 4 5 3];
pts = [ptsx' ptsy']; % 4 points total
order = 2;
maxindex = numel(ptsx);
r = order + numel(ptsx);
flag = 0;
knot = [0 0 0 0.4 1 1 1]; % 7 knot values.
if numel(knot)~=r+1
    display('Error: Knot vector is not correct size');
    flag = 1;
end
% Find the Basis Function:
if flag == 0
    N = Basis(ppoint(2),knot,order,2)
end
%% Generate the Nurbs Curve:
% w = double(1/4*ones(1,4));
% for x=1:numel(ppoint)
%     point = ppoint(x);
%     temp = Basis(point,knot,order,maxindex)';
%     Cu(x) = sum(w .* ptsx .* temp );
% end
% %% Plot the Curve:
% figure(1),
% hold on;
% plot(ptsx,ptsy,'ro--');
% title('Nurbs Curve');
% plot(linspace(0,5,numel(ppoint)),Cu,'bx');
% hold off;