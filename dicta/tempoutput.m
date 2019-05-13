function tempoutput(i, mutualKNN, segmentstatus)
Point = segmentstatus(segmentstatus(:, 1) == i, 2:3);
plot(Point(:,2), Point(:,1), '.'); hold on;
for j = 1:numel(mutualKNN)
    Point = segmentstatus(segmentstatus(:, 1) == mutualKNN(j), 2:3);
    plot(Point(:,2), Point(:,1), '.'); hold on;
end
end