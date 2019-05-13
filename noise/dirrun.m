function dirrun()
clc
dict = 'images';
A = dir(fullfile(dict));
for j = 1:numel(A)
    if A(j).isdir == 0
        fprintf('Code is running for %s\n', A(j).name);
        ImpulseNoise(dict, A(j).name);
    end
end
resultAnalysis('new_result_allimages');
end