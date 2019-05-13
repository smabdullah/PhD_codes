function Inew = localmean(I, W)
[r,c,~] = size(I);
Inew = I;
prevX = 1;
posX = 1;
for ii = 1:r
    prevY = 1;
    posY = 1;
    for jj = 1:c
        X = prevX:prevX+W-1;
        Y = prevY:prevY+W-1;
        
        X(X > r) = [];
        Y(Y > c) = [];
        
        P = mean(I(X,Y,:));
        [~,col,~] = size(P);
        if col > 1
            P = mean(P);
        end
        Inew(posX,posY,:) = I(posX, posY, :) - P;
        posY = posY + 1;
        prevY = prevY + 1;
    end
    posX = posX + 1;
    prevX = prevX + 1;
end
if max(Inew(:)) > 1
    Inew = Inew/max(Inew(:));
end
end