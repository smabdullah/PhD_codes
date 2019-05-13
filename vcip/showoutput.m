function showoutput(list1, list2, I)
out_image1 = I;
I1 = I(:,:,1);
I2 = I(:,:,2);
I3 = I(:,:,3);
[R,C] = ind2sub(size(I1), list1);
I1(sub2ind(size(I1), R, C)) = 1;
I2(sub2ind(size(I1), R, C)) = 0;
I3(sub2ind(size(I1), R, C)) = 0;

[R,C] = ind2sub(size(I1), list2);
I1(sub2ind(size(I1), R, C)) = 0;
I2(sub2ind(size(I1), R, C)) = 1;
I3(sub2ind(size(I1), R, C)) = 0;

out_image1(:,:,1) = I1;
out_image1(:,:,2) = I2;
out_image1(:,:,3) = I3;
imshow(out_image1);
end