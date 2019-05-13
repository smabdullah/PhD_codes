function printOutput(totalMD, totalFA, runLength, msg)
disp(msg);
count = 1;
for i = 0.1:0.1:0.9
    newMD = ceil(totalMD(count) / runLength);
    newFA = ceil(totalFA(count) / runLength);
    fprintf('For noise %d MD is %d and FA is %d\n', i*100, newMD, newFA);
    count = count + 1;
end
end