function predictImage = pixelInterpolation(I)
[row, col, ~] = size(I);
predictImage = I;

for i = 2:row-1
   for j = 2:col-1
      error_NW_SE = (abs(I(i, j-1) - I(i+1, j)) + abs(I(i-1, j) - I(i, j+1)) + 0.5 * abs(I(i-1, j-1) - I(i+1, j+1))) / 2.5;
      error_NE_SW = (abs(I(i-1, j) - I(i, j-1)) + abs(I(i, j+1) - I(i+1, j)) + 0.5 * abs(I(i-1, j+1) - I(i+1, j-1))) / 2.5;
      error_NS = (abs(I(i-1, j-1) - I(i, j-1)) + abs(I(i, j-1) - I(i+1, j-1)) + abs(I(i-1, j+1) - I(i, j+1)) + abs(I(i, j+1) - I(i+1, j+1))+ 0.5 * abs(I(i-1, j) - I(i+1, j))) / 4.5;
      error_EW = (abs(I(i-1, j-1) - I(i-1, j)) + abs(I(i-1, j) - I(i-1, j+1)) + abs(I(i+1, j-1) - I(i+1, j)) + abs(I(i+1, j) - I(i+1, j+1))+ 0.5 * abs(I(i, j-1) - I(i, j+1))) / 4.5;
      
      if error_NS == 0
          predictImage(i, j) = I(i-1, j);
      elseif error_EW == 0
          predictImage(i, j) = I(i, j-1);
      elseif error_NW_SE == 0
          predictImage(i, j) = I(i-1, j-1);
      elseif error_NE_SW == 0
          predictImage(i, j) = I(i-1, j+1);
      else
          value = (I(i-1, j-1) + I(i+1, j+1)) / error_NW_SE + (I(i-1, j+1) + I(i+1, j-1)) / error_NE_SW + (I(i-1, j) + I(i+1, j)) / error_NS + (I(i, j+1) + I(i, j-1)) / error_EW;
          totalweight = 1/error_NW_SE + 1/error_NE_SW + 1/error_NS + 1/error_EW;
          value = value / (2 * totalweight);
%           nor = I(i-1,j-1) + I(i-1,j) + I(i-1,j+1) + I(i,j-1) + I(i,j+1) + I(i+1,j-1) + I(i+1,j) + I(i+1,j+1);
          predictImage(i, j) = value;
      end
   end
end
end