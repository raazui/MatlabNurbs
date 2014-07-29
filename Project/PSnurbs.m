clc;clear;close all;
% Particle Swarm Optimization (Minimization):
% function [ fittest_value ] = PSnurbs(A,B,obj,np,d,maxNFC,c1...
%     ,c2, Wmax,Wmin,error)
% PSO Control Paramers: 
spheredemo; % TO DEMO WITH A SPHERE UNCOMMENT
% surfacedemo; %  TO DEMO WITH A SURFACE UNCOMMENT
obj = 'objective'; % Implicit call to the objetive function.
c1 = 2; % Learning Parameter 1 ( value obtained from paper )
c2 = 2; % Learning Parameter 2 ( value obtained from paper )
Wmax = 1; % Maximum Weight 
Wmin = 0; % Minimum Weight
error = 50; % Error at which the PSO stops
np = 100; % Population Size
%% Initialize the objective function:
costfun = str2func(obj); % Converts the string into a function handle.
%% Population Generation:
% Variables for generating population elements:
% Dimensionality of the problem:
Q = points; % [Nx3] point cloud.
% Sphere:
Q = points(1:169,:); % For sphere demo uncomment
% Surface:
% Q = points(1:16,:)  % For surfacedemo uncomment
N = size(Q,1);
m = 4; % Size of the control point grid in the ith direction
n = 4; % Size of the control point grid in the jth direction
k = 3; % Maximum curve order for U
l = 3; % Maximum curve order for V
% For surface:
% p = 4;
% q = 4;
% For sphere:
p = 13; % Size of point cloud data generated for error calculation (aplha)
q = 13; % Size of point cloud data generated for error calculation (beta)
nm = m*n; % Number of control points
% Puv(:,:,i) = param(Points,tmat(:,:,i),[]); 
% Population vector format:
% P = [cost P(x,y,z,w) S T U V];
P0 = struct([]);
gbest = struct([]);
for i = 1 : np
    % Generate Initial Costs:
    P0(i).cost = 1000; % Initial high cost will be overwritten.
    % Generate weight vector for each Point in range [0,2]:
    P0(i).w = 2*rand(nm,1);
    % Randomly Sample Control Points from Q:
    P0(i).loc = indexer(Q,nm);
    % Generate U:
    P0(i).u = linspace(0,1,p)';
    % Generate V:
    P0(i).v = linspace(0,1,q)';
    % Generate internal knot vector for U:
    P0(i).iku = ikgen(m,k);
    % Generate internal knot vector for V:
    P0(i).ikv = ikgen(n,l);
end
%% Loop Variables:
maxNFC = 25000; % Maximum Number of Allowed Function Calls
loop = 1; % Loop Variable;
fittest = maxNFC; % Initialize fitness set at 100.
NFC = 0; % Set the Number of function calls to 0.
cond1 = 1; % Condition for Assigning P-Best.
%% Optimize while the max NFC isnt reached or error condition is satisfied:
while( NFC < maxNFC && fittest > error )
    % Cycle through the population in order to update each particle
    for i=1:np
        %% Calculate the fittness value for each particle:
        cost = costfun(Q,P0(i).iku,P0(i).ikv,P0(i).u,P0(i).v,[P0(i).loc ...
        P0(i).w], m,n,k,l);
        P0(i).cost = cost;
        NFC = NFC + 1; % Update NFC.
        Progress = (NFC/maxNFC) * 100
        %% P-Best & G-Best:
        % Reset the Pbest to the first element in the population upon next
        % generation of paticles / itteration of alogirthm.
        if cond1 == 1
            pbest(loop) = P0(i);
            cond1 = 0;
            if isempty(gbest)
                gbest = pbest(loop);
            end
        end
        % If the particle fittness is better than the generation best
        % update the generation best to particle fittness
        if pbest(loop).cost > P0(i).cost
            pbest(loop) = P0(i);
            % G-Best:
            % If the particle fittness is better than the global best
            % update the generation best to particle fittness
            if gbest.cost > pbest(loop).cost
                gbest = pbest(loop);
                fittest = gbest.cost;
            end
        end
        % Store the gbest values:
        if i==np
            fittest_value(loop,1) = gbest.cost;
            fittest_value(loop,2) = NFC;
        end
        
        %% Calculate equations:
        % Calculate w:
        wi = Wmax - ( ( ( Wmax - Wmin) * NFC ) / maxNFC );
        %% Calculating the current velocity:
        fields = fieldnames(P0);
        l1 = rand(1);
        l2 = rand(1);
        % Update particle velocity:
        for a=2 : numel(fields)
            if loop==1
                v(i,loop).(fields{a}) = c1 * l1 .* ( ...
                    pbest(loop).(fields{a})...
                    - P0(i).(fields{a}) ) + c2 * l2 .* ( gbest.(fields{a})...
                    - P0(i).(fields{a}) );
            else
                v(i,loop).(fields{a}) = wi .* v(i,loop-1).(fields{a}) + c1 * l1 .* ( ...
                    pbest(loop).(fields{a})...
                    - P0(i).(fields{a}) ) + c2 * l2 .* ( gbest.(fields{a})...
                    - P0(i).(fields{a}) );
            end
        end
        for a=2: numel(fields)
            %% Update the particles position:
            P0(i).(fields{a}) = P0(i).(fields{a}) + v(i,loop).(fields{a});
            % Scale values so they dont exceed thresholds:
            if strcmp(fields{a},'w')
                temp =abs( P0(i).(fields{a}) );
                o = max(temp);
                if o > 2
                    temp = temp ./ max(temp);
                end
                P0(i).(fields{a}) = temp;
            end
            if strcmp(fields{a},'iku') || strcmp(fields{a},'ikv')
                temp = abs(P0(i).(fields{a}));
                temp( temp<= 0 ) = 0;
                temp( temp>= 1 ) = 1;
                P0(i).(fields{a}) = sort(temp);
            end
            if strcmp(fields{a},'u') || strcmp(fields{a},'v')
                temp = abs(P0(i).(fields{a}));
                temp( temp<= 0 ) = 0;
                temp( temp>= 1 ) = 1;
                P0(i).(fields{a}) = sort(temp);
            end
        end
     end
    
    % Update Loop indexing variables:
    if NFC > 1 % To Ensure only the proper number of generations are run.
        loop = loop + 1;
    end
    cond1 = 1; % Reset pbest initialization.
end
%% Display the surface:
displayPSO(Q,gbest.iku,gbest.ikv,gbest.u,gbest.v,[gbest.loc ...
        gbest.w], m,n,k,l)
%% Plot the error:
figure(2),
plot(fittest_value(:,2),fittest_value(:,1))
xlabel('Number of Function Calls');
ylabel('Error')
title('Error of best member vs. Number of Function Calls');