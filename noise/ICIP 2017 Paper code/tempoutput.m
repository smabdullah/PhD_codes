function tempoutput(i, segmentstatus)
Point = segmentstatus(segmentstatus(:, 1) == i, 2:3);
plot(Point(:,2), Point(:,1), '.'); hold on;
end