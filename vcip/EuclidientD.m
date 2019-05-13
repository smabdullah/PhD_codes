function Diff = EuclidientD(A,B)
Diff = sqrt(sum((A-B).*(A-B),2));
end