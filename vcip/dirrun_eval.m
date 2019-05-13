function dirrun_eval()
clc
count = 1;
dict = '2obj';
A = dir(fullfile(dict));
for j = 1:size(A,1)
    if A(j).isdir && (strcmp('.', A(j).name) == 0 && strcmp('..', A(j).name) == 0)
        Fdict = strcat(dict, '\', A(j).name, '\', 'src_color');
        folder_name = strcat(dict, '\', A(j).name);
        fprintf('[%d]: Processing image file: %s\n',count, A(j).name);
        levelSegmentation(Fdict, strcat(A(j).name, '.png'), folder_name);
        count = count + 1;
    end
end
end