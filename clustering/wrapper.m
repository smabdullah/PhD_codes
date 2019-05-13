%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function wrapper(varargin)
addpath('clusterlevel','distanceFunction', 'data');
variant = 1;

if nargin == 1
    clusterData = varargin{1};
else
    % generate/load cluster data
    load column2C
    % Create the linkage
%     clusterData = meas;
%     load('Tetra.mat')
    %load('heart.mat')
%     load('column2C.mat')
%     Y = dlmread('Aggregation.txt');
%     Y = Y(:,1:2);
    clusterData = column2C;
%       rng('default') % For reproducibility
%       clusterData = rand(20,3);
      Z = linkage(clusterData,'complete','@brayCurtisDistance');
end
% Check whether the edge costs are sorted or not

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%n = size(clusterData, 1);
replace by leaf nodes
if issorted(Z, 3) == 0
    Z = sortrows(Z, 3);
end

n = size(clusterData, 1);
Z(:, 4) = n+1:n+size(Z,1);
for i = 1:n-1
    if Z(i, 1) > n % replace by leaf node
        possibleValues = Z(Z(i, 1) - n, 1:2);
        if possibleValues(1) <= n
            Z(i, 1) = possibleValues(1);
        else
            Z(i, 1) = possibleValues(2);
        end
    end
    if Z(i, 2) > n % replace by leaf node
        possibleValues = Z(Z(i, 2) - n, 1:2);
        if possibleValues(1) <= n
            Z(i, 2) = possibleValues(1);
        else
            Z(i, 2) = possibleValues(2);
        end
    end
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
V = struct('size', [], 'p', [], 'level', [], 'maxcost', [], 'list', [], 'compact', [], 'separation', [], 'csp', []);

for i = 1:n
    V(i).size = 1;
    V(i).p = i;
    V(i).level = 0;
    V(i).maxcost = 0;
    V(i).list = i;
    V(i).compact = 0;
    V(i).separation = [];
    V(i).csp = 1;
end
% 
% 
% 
% [V, Z] = preCalculationData(clusterData, 'euclideanDistance');
nextpos = size(clusterData,1) + 1;
% figure, scatter(clusterData(:,1), clusterData(:,2), 'b'), hold on
if variant == 1
    V = clusterMerge_Variant_1(V, nextpos, Z, clusterData);
elseif variant == 2
    V = clusterMerge_Variant_2(V, nextpos, Z);
else
    V = clusterMerge_Variant_3(V, nextpos, Z);
end
X = clusterMapGenerator02(V, nextpos-1, clusterData);
% load('heart1.mat')
% Y = zeros(n,1);
% Y(column2C(:,1) == 'AB') = 1;
% Y(column2C(:,1) == 'NO') = 2;
% Y = dlmread('jain.txt');
% Y = Y(:,3);
Y = heart;
% fm_index(X,Y)
clustereval(X, Y, 'ri')
clustereval(X, Y, 'ari')
% rng(1); % for reproducibility
% X = kmeans(clusterData, 2);
% fm_index(X,Y)
end