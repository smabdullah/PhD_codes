function alphaTrimmedBitmap = alphaTrimmedMedian(Image)
% Luo, Wenbin. "An efficient detail-preserving approach for removing impulse noise in images." 
% IEEE signal processing letters 13.7 (2006): 413-416.
Ld = 1;
alpha = 0.35;
s = 1;
T = 30;
N = 4;
Wl = 20;
Wu = 40;
t = (2*Ld + 1)^2;

[row, col] = size(Image);
M = zeros(row-2, col -2);
count = zeros(row-2, col -2);
eta = zeros(row-2, col -2);
Xp = zeros((row-2)*(col-2), 9);
c = 1;

for i = 2: row - 1
   for j = 2: col - 1
      [X, count(i-1,j-1)] = getWindowValues(Image, i, j, N, T); 
      M(i-1, j-1) = calculateMean(X, t, alpha);
      Xp(c, :) = X;
      c = c + 1;
   end
end

Residual_1 = abs(double(Image(2:row-1, 2:col-1)) - M);
Residual_2 = Residual_1 .* count;

[rowR, colR] = size(Residual_2);

for i = 1:rowR
   for j = 1:colR
       if Residual_2(i,j) >= Wu
          eta(i,j) = 1;
       elseif Residual_2(i,j) >= Wl && Residual_2(i,j) < Wu
           eta(i,j) = 1;
       elseif Residual_2(i,j) < Wl
           eta(i,j) = 0;
       end
   end
end

c = 1;
for i = 2:row-1
   for j = 2:col-1
      X = Xp(c, :);
      c = c + 1;
      if Image(i,j) > X(s) && Image(i,j) < X(t-s+1)
          eta(i-1,j-1) = 0;
      end
   end
end

alphaTrimmedBitmap = reshape(eta, (row-2)*(col-2), 1);
end

function [X, val] = getWindowValues(Image, x, y, N, T)
X = zeros(9, 1);
count = 1;
countN = 0;
for i = -1:1
   for j = -1:1
       X(count) = Image(x+i, y+j);
       count = count + 1;
       if i ~= 0 && j ~= 0
           if abs(Image(x, y) - Image(x+i, y+j)) < T
               countN = countN + 1;
           end
       end
   end
end
if countN >= N
    val = 0;
else
    val = 1;
end
X = sort(X);
end

function value = calculateMean(X, t, alpha)
value = 0;
for i = floor(alpha*t) + 1: t - floor(alpha*t)
   value = value + X(i); 
end
value = value / (t - 2*floor(alpha*t));
end