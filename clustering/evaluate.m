function evaluate()
myfunc = @(x,k) clusterdata(x,'linkage','single','maxclust',k);
optimalK = false;

% load the data
disp('TwoDiamonds dataset');
load('TwoDiamonds.mat')
X = TwoDiamonds;

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

load('TwoDiamonds1')
X = TwoDiamonds;

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('Column2C dataset');
load('column2C.mat')
X = column2C;
CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

load('column2C1')
X = zeros(310,1);
X(strcmp(column2C, 'AB')) = 1;
X(strcmp(column2C, 'NO')) = 2;

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('Heart dataset');
load('heart.mat')
X = heart;

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

load('heart1')
X = heart;
if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('Tae dataset');
load('tae.mat')
X = tae;

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

load('tae1')
X = tae1;

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('Pageblocks dataset');
load('pageblocks.mat')
X = pageblocks;

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

load('pageblocks1')
X = pageblocks1;

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('Oil dataset');
load('labeled.mat')
X = labeleddata;

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

X = labeledlabel;

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('CNAE9 dataset');
load('CNAE9.mat')
X = CNAE9(:,2:end);

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[5:14]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[5:14]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[5:14]);

X = CNAE9(:,1);

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('Target dataset');
load('target.mat')
X = Target;

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:10]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:10]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:10]);

load('Target1')
X = Target1;

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('EngyTime dataset');
load('EngyTime.mat')
X = EngyTime;

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

load('EngyTime1')
X = EngyTime1;

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('WingNut dataset');
load('WingNut.mat')
X = WingNut1;

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

load('WingNut1')
X = WingNut;

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('Spiral dataset');
y = dlmread('spiral.txt');
X = y(:,1:2);

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

X = y(:,3);

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('Aggregation dataset');
y = dlmread('Aggregation.txt');
X = y(:,1:2);

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[3:10]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[3:10]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[3:10]);

X = y(:,3);

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('Compound dataset');
y = dlmread('Compound.txt');
X = y(:,1:2);

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[2:9]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[2:9]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[2:9]);

X = y(:,3);

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('Jain dataset');
y = dlmread('jain.txt');
X = y(:,1:2);

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

X = y(:,3);
if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end

% load the data
disp('TwoDiamonds dataset');
load('TwoDiamonds.mat')
X = TwoDiamonds;

CH = evalclusters(X,myfunc,'CalinskiHarabasz','KList',[1:6]);
DB = evalclusters(X,myfunc,'DaviesBouldin','KList',[1:6]);
Sli = evalclusters(X,myfunc,'silhouette','KList',[1:6]);

load('TwoDiamonds1')
X = TwoDiamonds;

if ~optimalK
    disp('Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ri'));
    disp(clustereval(X, DB.OptimalY, 'ri'));
    disp(clustereval(X, Sli.OptimalY, 'ri'));
    
    disp('Adjusted Rand Index');
    disp(clustereval(X, CH.OptimalY, 'ari'));
    disp(clustereval(X, DB.OptimalY, 'ari'));
    disp(clustereval(X, Sli.OptimalY, 'ari'));
else
    disp(CH.OptimalK);
    disp(DB.OptimalK);
    disp(Sli.OptimalK);
end
end