function status = finditout(S, p)
status = false;
for i = 1:numel(S)
   if S(i) == p
       status = true;
       return;
   end
end
end