%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% http://reference.wolfram.com/language/ref/CanberraDistance.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function distance = canberraDistance(X, Y)
distance = sum(abs(X - Y) ./ (abs(X) + abs(Y)), 2);
end