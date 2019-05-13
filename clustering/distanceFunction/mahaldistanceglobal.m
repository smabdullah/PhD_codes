function Diff = mahaldistanceglobal(X,Y)
A = X' - Y';
S = cov(X) + cov(Y);
%D1 = (A/S)';
% D1 = (A * pinv(S))';
% Diff = sqrt(dot(D1,A'));

%Diff = sqrt(diag(A' * pinv(S) * A));
Diff = sqrt(diag(A' * pinv(S) * A));
end