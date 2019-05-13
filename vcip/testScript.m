function testScript()
A = randi(50000, 30000);
B = randi(10000, 20000);

sz = numel(A) + numel(B);

V1 = struct('list', []);
V2 = struct('list', []);
V3 = struct('list', []);

for i = 1:10
   V1(i).list = 0;
   V2(i).list = 0;
   V3(i).list = 0;
end
tic;
for i = 1:1000
   V1(i).list = [A;B]; 
end
toc;
tic;
for i = 1:1000
   V2.list = zeros(sz, 1, 'int32');
   V2.list(:) = [A;B];
end
toc;
tic;
for i = 1:1000
  V3.list = repmat([A;B],1);
end
toc;
end
