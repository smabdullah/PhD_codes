function Diff = mahaldistanceglobal(X,Y)
A = X - Y;
S = cov(X) + cov(Y);
D1 = (A/S)';
Diff = sqrt(dot(D1,A'));
end