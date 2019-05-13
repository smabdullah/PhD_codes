function Diff = EuclidientD(A,B)
Diff = (sum((A-B).*(A-B),2)).^0.5;
end