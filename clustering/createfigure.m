function createfigure(X1, Y1, X2, Y2, X3, Y3)
%CREATEFIGURE(X1, Y1, X2, Y2, X3, Y3)
%  X1:  scatter x
%  Y1:  scatter y
%  X2:  scatter x
%  Y2:  scatter y
%  X3:  scatter x
%  Y3:  scatter y

%  Auto-generated by MATLAB on 17-Apr-2018 18:46:28

% Create figure
figure('OuterPosition',[395 226 576 513]);

% Create axes
axes1 = axes;
hold(axes1,'on');

% Create scatter
scatter(X1,Y1);

% Create scatter
scatter(X2,Y2);

% Create scatter
scatter(X3,Y3);

grid on
