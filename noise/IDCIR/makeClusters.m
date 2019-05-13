function S = makeClusters(I, N)
S = struct('members', []);
[length,~,~] = size(I);
flag = zeros(length, 1, 'uint8');
pos = 1;
delta = 40;
count = 1;
pointer = 1;

for i = 1:length
    if flag(i) == false
        temp = zeros(1000,1);
        temp(count) = i;
        flag(i) = true;
        while pointer <= count
            for j = 1:8
                if N(temp(pointer), j) ~= 0 && flag(N(temp(pointer), j)) == false
                    dis = findDistance(i, N(temp(pointer),j), I);
                    if dis <= delta
                        count = count + 1;
                        temp(count) = N(temp(pointer),j);
                        flag(N(temp(pointer),j)) = true;
                    end
                end
            end
            pointer = pointer + 1;
        end
        S(pos).members = temp(1:count);
        pos = pos + 1;
        count = 1;
        pointer = 1;
    end
end
end

function D = findDistance(x, y, I)
D = sqrt(sum((I(x,:) - I(y,:)).^2));
end