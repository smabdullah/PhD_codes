function deltaE = deltargb(A, B)
sz = numel(A);
if sz == 3
    deltaE = sqrt(double((A(1) - B(1)) * (A(1) - B(1)) + (A(2) - B(2)) * (A(2) - B(2)) + (A(3) - B(3)) * (A(3) - B(3))));
elseif sz == 1
    deltaE = sqrt(double(A - B));
end
end