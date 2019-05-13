function distance = pearsonCorrelation(X,Y)
meanX = mean(X,2);
stdX = std(X,0,2);
meanY = mean(Y,2);
stdY = std(Y,0,2);
distance = 1-(sum(((X - meanX)./stdX) .* ((Y - meanY)./stdY),2) / size(X,2));
end