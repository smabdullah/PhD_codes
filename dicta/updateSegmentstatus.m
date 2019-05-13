function segmentstatus = updateSegmentstatus(mutualKNN, currseg, segmentstatus)
for i = 1:size(mutualKNN, 2)
    T = segmentstatus(:,1) == mutualKNN(i);
    segmentstatus(T, 1) = currseg;
end
end