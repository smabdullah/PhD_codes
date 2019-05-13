function dirrun()
clc
count = 1;
dict = uigetdir('..\benchmark images');
A = dir(fullfile(dict,'*.jpg'));
folder_name = 'CIELAB_deltaE2000_V2';
for j = 1:200
    if A(j).isdir == 0
        fprintf('[%d]: Processing image file: %s\n',count, A(j).name); 
        levelSegmentation(dict, A(j).name, folder_name);
        count = count + 1;
    end
end
dirrunmatfile(folder_name);
end