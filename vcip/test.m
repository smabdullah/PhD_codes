function test()
%clear all;
sz = 10;
D = randi(1000,[sz,1],'double');
[B, I] = sort(D);
tic
for i = 1:1000000
    if ~issorted(B)
        [B, I] = sort(D);
    end
end
toc
end