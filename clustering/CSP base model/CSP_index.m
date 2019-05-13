function CSP_index()
%addpath('heart');
load('Atom.mat')
% Y = dlmread('data.txt');
%     Y = Y(:,1:2);
clusterData = Atom;
% rng default;
% clusterData = rand(20,3);
kmin = 2;
kmax = floor(sqrt(size(clusterData, 1)));
CSP_list = zeros(kmax-kmin+1, 2);
j = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Z = linkage(clusterData,'single','euclidean');
if issorted(Z, 3) == 0
    Z = sortrows(Z, 3);
end

n = size(clusterData, 1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%replace by leaf nodes
% Z(:, 4) = n+1:n+size(Z,1);
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X = zeros((n*(n-1))/2,2);
% count = 1;
% for i = 1:n
%    for j = i+1:n
%        X(count, :) = [i, j];
%        count  = count + 1;
%    end
% end
% Diff = brayCurtisDistance(clusterData(X(:,1),:), clusterData(X(:,2),:));
% X(:,3) = Diff;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Loc = struct('data', []);
for i = 1:kmax-kmin+1
    Loc(i).data = [];
end
for i = kmin:1:kmax
    [pq, Loc(j).data] = formCluster(Z, i, clusterData);
    CSP_list(j, 1:2) = [i, pq];
    j = j + 1;
end
[val, ind] = max(CSP_list(:,2));
fprintf('The maximum CSP is %0.3f with %d clusters\n', val, CSP_list(ind, 1));
% Y = dlmread('jain.txt');
% Y = Y(:,3);
load('TwoDiamonds1.mat')
% Y = zeros(n,1);
% Y(column2C(:,1) == 'AB') = 1;
% Y(column2C(:,1) == 'NO') = 2;
Y = TwoDiamonds;
% fm_index(Loc(ind).data,Y)
clustereval(Loc(ind).data, Y, 'ri')
clustereval(Loc(ind).data, Y, 'ari')
end

function [avgCSP, cluster_loc] = formCluster(Distance, k, clusterData)
c = size(clusterData, 1);
% distance calculation
% n = 1;
% Distance = zeros((c*(c-1)), 3);
cluster = struct('data', [], 'cd', []);
cluster_loc = zeros(c,1, 'int32');

% for i = 1:size(n_data,1)
%     for j = 1:size(n_data, 1)
%         if i ~= j
%             Distance(n,:) = [i, j, EuclidientD(n_data(i,:), n_data(j,:))];
%             n = n + 1;
%         end
%     end
% end
clusterID = 1;

while c > k
    [~, ind] = min(Distance(:,3));
    a = Distance(ind, 1);
    b = Distance(ind, 2);
    if cluster_loc(a) == 0 && cluster_loc(b) == 0
        cluster(clusterID).data = repmat([a ; b], 1);
        if isempty(cluster(clusterID).cd) == 0
            cluster(clusterID).cd = cluster(clusterID).cd + Distance(ind, 3);
        else
            cluster(clusterID).cd = Distance(ind, 3);
        end
        cluster_loc(a) = clusterID;
        cluster_loc(b) = clusterID;
        clusterID = clusterID + 1;
        c = c - 1;
    elseif cluster_loc(a) ~= cluster_loc(b)
        loc = max(cluster_loc(a),cluster_loc(b));
        val = min(cluster_loc(a),cluster_loc(b));
        if val ~= 0
            cluster(loc).data = repmat([cluster(loc).data; cluster(val).data],1);
            if isempty(cluster(loc).cd) == 0
                cluster(loc).cd = cluster(loc).cd + Distance(ind, 3);
            else
                cluster(loc).cd = Distance(ind, 3);
            end
            cluster_loc(cluster(loc).data) = loc;
        elseif val == 0 && cluster_loc(a) == 0
            cluster(loc).data = repmat([cluster(loc).data; a],1);
            if isempty(cluster(loc).cd) == 0
                cluster(loc).cd = cluster(loc).cd + Distance(ind, 3);
            else
                cluster(loc).cd = Distance(ind, 3);
            end
            cluster_loc(cluster(loc).data) = loc;
        elseif val == 0 && cluster_loc(b) == 0
            cluster(loc).data = repmat([cluster(loc).data; b],1);
            if isempty(cluster(loc).cd) == 0
                cluster(loc).cd = cluster(loc).cd + Distance(ind, 3);
            else
                cluster(loc).cd = Distance(ind, 3);
            end
            cluster_loc(cluster(loc).data) = loc;
        end
        c = c - 1;
    end
    Distance(ind, 3) = intmax;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pqr = find(cluster_loc == 0);
for i = 1:numel(pqr)
    cluster_loc(pqr(i)) = clusterID;
    cluster(clusterID).data = pqr(i);
    cluster(clusterID).cd = 0;
    clusterID = clusterID + 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
newCluster = struct('data', [], 'cd', [], 'sp', [], 'csp', []);
[l, ia, ~] = unique(cluster_loc);
n = numel(l);
minValues = ones(n, 1);
minValues(:) = intmax;
clusterMember = struct('member', []);
pqcount = 1;
for i = 1:n
    clusterMember(i).member = find(cluster_loc == l(i));
    pqcount = pqcount + 1;
end

% pq = find(cluster_loc == 0);
%
% for i = 1:numel(pq)
%     clusterMember(pqcount).member = pq(i);
%     pqcount = pqcount + 1;
% end

for i = 1:n
    cluster_loc(clusterMember(i).member) = i;
    newCluster(i).data = cluster(l(i)).data;
    if numel(newCluster(i).data) > 1
        newCluster(i).cd = cluster(l(i)).cd / (numel(cluster(l(i)).data)-1);
    else
        newCluster(i).cd = 0;
    end
    newCluster(i).sp = 1;
end
flag = 1;
while flag
    [~, ind] = min(Distance(:,3));
    X = cluster_loc(Distance(ind, 1));
    Y = cluster_loc(Distance(ind, 2));
    if X ~= Y
        minValues(X) = min(minValues(X), Distance(ind, 3));
        minValues(Y) = min(minValues(Y), Distance(ind, 3));
    end
    Distance(ind, 3) = intmax;
    count = 1;
    for i = 1:numel(minValues)
        if minValues(i) == intmax
            count = 0;
            break;
        end
    end
    if count == 0
        flag = 1;
    else
        flag = 0;
    end
end
for i = 1:numel(minValues)
    newCluster(i).sp = minValues(i);
    newCluster(i).csp = (newCluster(i).sp - newCluster(i).cd) / (newCluster(i).sp + newCluster(i).cd);
end
avgCSP = mean(cell2mat({newCluster(1:end).csp}));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
here = 1;
end