function [I, I1] = resultanalysis2(Inew, segmentstatus, row, col)
I = zeros(row, col);
I1 = I;
sz = max(segmentstatus(:,1));
for i = 1:sz
    A = Inew(segmentstatus(segmentstatus(:,1) == i, 4),:);
    M = median(A, 1);
    r = M(1)/255;
    g = M(2)/255;
    b = M(3)/255;
    
    I1 = putvalues(I1, r, g, b, segmentstatus(segmentstatus(:,1) == i, 2:3));
    I = putvalues(I, rand, rand, rand, segmentstatus(segmentstatus(:,1) == i, 2:3));
end
end

function I = putvalues(I, r, g, b, ind)
for i = 1:size(ind, 1)
    I(ind(i,1), ind(i,2),1:3) = [r,g,b];
end
end