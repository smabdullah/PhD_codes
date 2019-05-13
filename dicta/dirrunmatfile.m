function dirrunmatfile(subfolder)
count = 1;
[~, folder, ~] = fileparts(pwd);
matpath = strcat('../', folder, '_mat files/', subfolder, '/output');
if ~isdir(matpath)
    mkdir(matpath);
end
%dict = uigetdir();
dict = strcat('../', folder, '_mat files/', subfolder);
A = dir(dict);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxsize = 0;
for j = 1:size(A,1)
   if A(j).isdir == 0
      matfile = strcat(dict, '/', A(j).name);
      load(matfile);
      sz = size(segs, 1);
      if sz > maxsize
         maxsize = sz;
         name = A(j).name;
      end
   end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j = 1:size(A,1)
    if A(j).isdir == 0
        fprintf('[%d]: Processing mat file: %s\n',count, A(j).name);
        [~,name,~] = fileparts(A(j).name);
        matfile = strcat(dict, '/', A(j).name);
        segs = processingmatfile(matfile, maxsize);
        count = count + 1;
        fname = strcat(matpath, '/', name, '.mat');
        save(fname, 'segs');
    end
end
end