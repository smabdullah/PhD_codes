function distance = CorrelationDistance(X, Y)
% http://reference.wolfram.com/language/ref/CorrelationDistance.html
A = X - repmat(mean(X, 2), 1, size(X, 2));
B = Y - repmat(mean(Y, 2), 1, size(Y, 2));
distance = 1 - ((sum(A .* B,2)) ./ (sum(A.^2,2) .* sum(B.^2,2)));
end