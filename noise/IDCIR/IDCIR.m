%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementation of An Impulse Detector for Color Image Restoration (2006)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bitmapImage = IDCIR(I)
[row, col, dim] = size(I);
I_n = 1:row*col;
I_n_mat = reshape(I_n, row, col);
Ivector = reshape(I, row*col, dim);

neighbour = zeros(row*col, 8, 'uint32');
count = 1;

for i = 1:col
   for j = 1:row
      neighbour(count,:) = findNeighbours(I_n_mat, j, i, row, col); 
      count = count + 1;
   end
end

S = makeClusters(Ivector, neighbour);
bitmapImage = createBitmapImage(S, row, col);
end