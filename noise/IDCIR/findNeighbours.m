function N = findNeighbours(I, x, y, row, col)
N = zeros(1,8, 'uint32');
count = 1;
if x-1 >= 1 && y-1 >= 1
   N(count) = I(x-1,y-1); 
   count = count + 1;
end

if y-1 >= 1
   N(count) = I(x, y-1);
   count = count + 1;
end

if x+1 <= row && y-1 >= 1
   N(count) = I(x+1,y-1);
   count = count + 1;
end

if x-1 >= 1
   N(count) = I(x-1,y);
   count = count + 1;
end

if x+1 <= row
   N(count) = I(x+1,y);
   count = count + 1;
end

if x-1 >= 1 && y+1 <= col
   N(count) = I(x-1,y+1);
   count = count + 1;
end

if y+1 <= col
   N(count) = I(x,y+1);
   count = count + 1;
end

if x+1 <= row && y+1 <= col
   N(count) = I(x+1, y+1);
   count = count + 1;
end
end