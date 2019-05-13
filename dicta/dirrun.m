function dirrun()
count = 1;
dict = uigetdir('..\benchmark images');
A = dir(dict);
L = regexp(dict, '\');
folder_name = dict(L(end)+1:end);
for j = 1:size(A,1)
%     if j < 18
%         continue;
%     end
%     if j == 63
%         break;
%     end
    if A(j).isdir == 0
        fprintf('[%d]: Processing image file: %s\n',count, A(j).name); 
        HMNNSegmentation(dict, A(j).name, folder_name);
        count = count + 1;
    end
end
dirrunmatfile(subfolder);
end