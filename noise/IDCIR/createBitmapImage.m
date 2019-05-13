function B = createBitmapImage(S, W, H)
T = (findT(S, 2)*100)/ (W*H);
B = zeros(W*H, 1, 'uint8');
if T < 0.9
    Smax = 1;
elseif T >= 0.9 && T < 9.6
    Smax = 2;
elseif T >= 9.6 && T <23
    Smax = 3;
elseif T >= 23 && T < 31
    Smax = 4;
elseif T >= 31 && T < 39
    Smax = 5;
else
    Smax = 6;
end

for i = 1:numel(S)
   len = numel(S(i).members);
   if len <= Smax
      B(S(i).members) = 1; 
   end
end
end

function T = findT(S, n)
T = 0;
for i = 1:numel(S)
    len = numel(S(i).members);
    if len <= n
        T = T + len;
    end
end
end