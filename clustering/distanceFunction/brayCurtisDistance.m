% http://reference.wolfram.com/language/ref/BrayCurtisDistance.html
function distance = brayCurtisDistance(X, Y)
distance = sum(abs(X-Y),2) ./ sum(abs(X+Y),2);
end