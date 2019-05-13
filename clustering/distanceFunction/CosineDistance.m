function distance = CosineDistance(X, Y)
value = dot(X,Y,2)/(norm(X) * norm(Y));
% if value < 0.0000001
%     distance = 0;
%     return;
% end
distance = rad2deg(acos(value));
end