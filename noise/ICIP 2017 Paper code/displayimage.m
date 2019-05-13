function displayimage(row, col, V, a, b, I, m1, m2, c)
out_img = ones(row, col, 3);
Ra = rand;
Ga = rand;
Ba = rand;

Rb = rand;
Gb = rand;
Bb = rand;
msg = strcat('V(a).level=', num2str(m1), ',', 'V(b).level=', num2str(m2), 'cost=', num2str(c));
for j = 1:row
    for p = 1:col
        c = (j-1) * col + p;
        [q, V] = findout(c, V);
        if q == a
            out_img(j, p, 1:3) = [Ra, Ga, Ba];
        elseif q == b
            out_img(j, p, 1:3) = [Rb, Gb, Bb];
        else
            out_img(j, p, 1) = I(j,p,1);
            out_img(j, p, 2) = I(j,p,2);
            out_img(j, p, 3) = I(j,p,3);
        end
    end
end
figure('name', msg),imshow(out_img); hold on;
end