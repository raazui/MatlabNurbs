% Project Files:
% % Test files:
% spheredemo.m % Generates points for a sphere
% surfacedemo.m % Generates points for a surface
% objtester.m % Evaluates the NURBS curve at (ie. this is radomly generated solution that would be initialized by the PSO)
% Nurbstester.m % Evaluates a NURBS curve showing the curve and the blending polynomials
% 
% % Nurbs Related Files:
% basisgen.m % Generates the values for the basis functions evaluated at point u (first basis function has errors)
% ikgen.m % Generates random internal knot values for a non-uniform knot vector
% knotgen.m % Generates a knot a non-uniform non-periodic knot vector
% surfacgen.m % Generates the NURBS surface
% 
% % PSO Files:
% PSnurbs.m % PSO function for generating nurbs curves
% displayPSO.m % Used in PSO to display the output of the PSO
% objective.m % Objective function for the PSO
% indexer.m % Randomly samples point cloud data to obtain control points