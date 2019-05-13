function [V, pixelLevel] = levelSegmentationMerge02(V, nextpos, E, Inew)
i = 1;
flag = true;
sz = size(E, 1) + 1;
maxLevel = ceil(log2(sz));
pixelLevel = zeros(sz, maxLevel, 'int32');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row, col, ~] = size(Inew);
tempJ1 = reshape(Inew(:,:,1), row*col, 1);
    tempJ2 = reshape(Inew(:,:,2), row*col, 1);
    tempJ3 = reshape(Inew(:,:,3), row*col, 1);
    J = [tempJ1,tempJ2,tempJ3];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while flag
    [a, b] = findout03(E(i, 1), E(i, 2), V);
    if a ~= b
%         if V(a).level >= 1 && V(b).level >= 1
%             newcost = deltaE2000(mean(J(V(a).list, :)), mean(J(V(b).list, :)));
%             if newcost < E(i,3) && (V(a).size >= sz*0.01 || V(b).size >= sz*0.01)
%                 disp(newcost);
%                 disp(E(i,3));
%                 figure, imshow(Inew,[])
%                 hold on;
%                 [R,C] = ind2sub(size(Inew(:,:,1)), V(a).list);
%                 plo_t(C, R, '.');
%                 [R,C] = ind2sub(size(Inew(:,:,1)), V(b).list);
%                 plot(C, R, '.');
%                 here = 1;
%             end
%         end
        if V(a).level == V(b).level
            if E(i,3) <= V(a).maxcost && E(i,3) <= V(b).maxcost
                if V(a).size >= V(b).size
                    if V(a).size == 1 && V(b).size == 1
                        V(nextpos).maxcost = E(i,3);
                        V(nextpos).level = V(a).level + 1;
                        V(nextpos).p = nextpos;
                        V(nextpos).size = V(a).size + V(b).size;
                        V(nextpos).list = [V(a).list;V(b).list];
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        pixelLevel(V(nextpos).list, V(nextpos).level) = nextpos;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).p = nextpos;
                        V(b).p = nextpos;
                        nextpos = nextpos + 1;
                    else
                        V(a).size = V(a).size + V(b).size;
                        V(a).list = [V(a).list;V(b).list];
                        V(a).maxcost = E(i,3);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        pixelLevel(V(a).list, V(a).level) = a;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(b).p = V(a).p;
                        V(b).level = -1;
                    end
                else
                    if V(a).size == 1 && V(b).size == 1
                        V(nextpos).maxcost = E(i,3);
                        V(nextpos).level = V(a).level + 1;
                        V(nextpos).p = nextpos;
                        V(nextpos).size = V(a).size + V(b).size;
                        V(nextpos).list = [V(a).list;V(b).list];
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        pixelLevel(V(nextpos).list, V(nextpos).level) = nextpos;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).p = nextpos;
                        V(b).p = nextpos;
                        nextpos = nextpos + 1;
                    else
                        V(b).size = V(a).size + V(b).size;
                        V(b).list = [V(a).list;V(b).list];
                        V(b).maxcost = E(i,3);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        pixelLevel(V(b).list, V(b).level) = b;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).p = V(b).p;
                        V(a).level = -1;
                    end
                end
            else
                V(nextpos).maxcost = E(i,3);
                V(nextpos).level = V(a).level + 1;
                V(nextpos).p = nextpos;
                V(nextpos).size = V(a).size + V(b).size;
                V(nextpos).list = [V(a).list;V(b).list];
                pixelLevel(V(nextpos).list, V(nextpos).level) = nextpos;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                V(a).p = nextpos;
                V(b).p = nextpos;
                nextpos = nextpos + 1;
            end
        else
            leveldiff = abs(V(a).level - V(b).level);
            if (V(a).level < V(b).level)
                if leveldiff > 1
                    V(a).p = nextpos;
                end
                for ii = V(a).level+1:V(b).level-1
                    V(nextpos).maxcost = V(a).maxcost;
                    V(nextpos).level = ii;
                    V(nextpos).size = V(a).size;
                    V(nextpos).p = nextpos+1;
                    V(nextpos).list = V(a).list;
                    pixelLevel(V(nextpos).list, V(nextpos).level) = nextpos;
                    nextpos = nextpos + 1;
                end
                if leveldiff > 1
                    V(nextpos-1).p = V(b).p;
                else
                    V(a).p = V(b).p;
                end
                V(b).size = V(a).size + V(b).size;
                V(b).list = [V(a).list;V(b).list];
                pixelLevel(V(a).list, V(b).level) = b;
                V(b).maxcost = E(i,3);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            else
                if leveldiff > 1
                    V(b).p = nextpos;
                end
                for ii = V(b).level+1:V(a).level-1
                    V(nextpos).maxcost = V(b).maxcost;
                    V(nextpos).level = ii;
                    V(nextpos).size = V(b).size;
                    V(nextpos).p = nextpos+1;
                    V(nextpos).list = V(b).list;
                    pixelLevel(V(nextpos).list, V(nextpos).level) = nextpos;
                    nextpos = nextpos + 1;
                end
                if leveldiff > 1
                    V(nextpos-1).p = V(a).p;
                else
                    V(b).p = V(a).p;
                end
                V(a).size = V(a).size + V(b).size;
                V(a).list = [V(a).list;V(b).list];
                V(a).maxcost = E(i,3);
                pixelLevel(V(b).list, V(a).level) = a;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
        end
    end
    i = i + 1;
    if i > size(E,1)
        flag = false;
    end
end
X = find(pixelLevel(1,:) == 0);
pixelLevel = pixelLevel(:,1:X(1)-1);
end