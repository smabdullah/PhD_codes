function resultAnalysis(file)
steps = 9;
A = dir(fullfile('results', 'temp'));
images = numel(A) - 2;
Images = 1:images;

our_method_MD = zeros(images, steps);
BDND_MD = zeros(images, steps);
SMFID_MD = zeros(images, steps);
SMFID_2010_MD = zeros(images, steps);
alpha_trimmed_MD = zeros(images, steps);
IDCIR_MD = zeros(images, steps);

our_method_FA = zeros(images, steps);
BDND_FA = zeros(images, steps);
SMFID_FA = zeros(images, steps);
SMFID_2010_FA = zeros(images, steps);
alpha_trimmed_FA = zeros(images, steps);
IDCIR_FA = zeros(images, steps);

count = 1;
for i = 1:numel(A)
    if A(i).isdir == 0
        % read MD
        temp_MD = readtable(fullfile('results', 'temp', A(i).name), 'Range', 'A3:G12');
        temp_MD = table2array(temp_MD);
        our_method_MD(count, :) = temp_MD(:,2)';
        BDND_MD(count, :) = temp_MD(:,3)';
        SMFID_MD(count, :) = temp_MD(:,4)';
        SMFID_2010_MD(count, :) = temp_MD(:,5)';
        alpha_trimmed_MD(count, :) = temp_MD(:,6)';
        IDCIR_MD(count, :) = temp_MD(:,7)';
        
        % read FA
        temp_FA = readtable(fullfile('results', 'temp', A(i).name), 'Range', 'J3:P12');
        temp_FA = table2array(temp_FA);
        our_method_FA(count, :) = temp_FA(:,2)';
        BDND_FA(count, :) = temp_FA(:,3)';
        SMFID_FA(count, :) = temp_FA(:,4)';
        SMFID_2010_FA(count, :) = temp_FA(:,5)';
        alpha_trimmed_FA(count, :) = temp_FA(:,6)';
        IDCIR_FA(count, :) = temp_FA(:,7)';
        
        count = count + 1;
    end
end

excelFileName = fullfile('results', strcat('resultAnalysis_', file, '.xlsx'));

for i = 1:steps
    table_MD = table(Images', our_method_MD(:,i),BDND_MD(:,i),SMFID_MD(:,i),SMFID_2010_MD(:,i),alpha_trimmed_MD(:,i),IDCIR_MD(:,i));
    table_MD.Properties.VariableNames = {'Image_number', 'Our_method', 'BDND', 'SMFID', 'SMFID_2010', 'alpha_trimmed', 'IDCIR'};
    table_MD.Properties.Description = 'Miss Detection Result';
    writetable(table_MD, excelFileName, 'Sheet', i, 'Range', 'A1', 'WriteRowNames', true);
    
    table_FA = table(Images', our_method_FA(:,i),BDND_FA(:,i),SMFID_FA(:,i),SMFID_2010_FA(:,i),alpha_trimmed_FA(:,i),IDCIR_FA(:,i));
    table_FA.Properties.VariableNames = {'Image_number', 'Our_method', 'BDND', 'SMFID', 'SMFID_2010', 'alpha_trimmed', 'IDCIR'};
    table_FA.Properties.Description = 'False alarm Result';
    writetable(table_FA, excelFileName, 'Sheet', i, 'Range', 'J1', 'WriteRowNames', true);
end

density = 10:10:90;
our_method_mean = zeros(steps, 1);
BDND_mean = zeros(steps, 1);
SMFID_mean = zeros(steps, 1);
SMFID_2010_mean = zeros(steps, 1);
alpha_trimmed_mean = zeros(steps, 1);
IDCIR_mean = zeros(steps, 1);

our_method_mean2 = zeros(steps, 1);
BDND_mean2 = zeros(steps, 1);
SMFID_mean2 = zeros(steps, 1);
SMFID_2010_mean2 = zeros(steps, 1);
alpha_trimmed_mean2 = zeros(steps, 1);
IDCIR_mean2 = zeros(steps, 1);

for i = 1:steps
    our_method_mean(i) = ceil(mean(our_method_MD(:,i)));
    BDND_mean(i) = ceil(mean(BDND_MD(:,i)));
    SMFID_mean(i) = ceil(mean(SMFID_MD(:,i)));
    SMFID_2010_mean(i) = ceil(mean(SMFID_2010_MD(:,i)));
    alpha_trimmed_mean(i) = ceil(mean(alpha_trimmed_MD(:,i)));
    IDCIR_mean(i) = ceil(mean(IDCIR_MD(:,i)));
    
    our_method_mean2(i) = ceil(mean(our_method_FA(:,i)));
    BDND_mean2(i) = ceil(mean(BDND_FA(:,i)));
    SMFID_mean2(i) = ceil(mean(SMFID_FA(:,i)));
    SMFID_2010_mean2(i) = ceil(mean(SMFID_2010_FA(:,i)));
    alpha_trimmed_mean2(i) = ceil(mean(alpha_trimmed_FA(:,i)));
    IDCIR_mean2(i) = ceil(mean(IDCIR_FA(:,i)));
end

table_MD = table(density', our_method_mean,BDND_mean,SMFID_mean,SMFID_2010_mean,alpha_trimmed_mean,IDCIR_mean);
table_MD.Properties.VariableNames = {'Noise_density', 'Our_method', 'BDND', 'SMFID', 'SMFID_2010', 'alpha_trimmed', 'IDCIR'};
table_MD.Properties.Description = 'Miss Detection Result';
writetable(table_MD, excelFileName, 'Sheet', steps+1, 'Range', 'A1', 'WriteRowNames', true);

table_FA = table(density', our_method_mean2,BDND_mean2,SMFID_mean2,SMFID_2010_mean2,alpha_trimmed_mean2,IDCIR_mean2);
table_FA.Properties.VariableNames = {'Noise_density', 'Our_method', 'BDND', 'SMFID', 'SMFID_2010', 'alpha_trimmed', 'IDCIR'};
table_FA.Properties.Description = 'False alarm Result';
writetable(table_FA, excelFileName, 'Sheet', steps+1, 'Range', 'J1', 'WriteRowNames', true);

% removing all files from temp folder
%cd 'results\temp';
%delete *.xlsx;
end