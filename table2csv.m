function table2csv(table,filename)
  txt="";
  for i=1:size(table,1)
    for j=1:size(table,2)
      if iscell(table(i,j))
        txt=[txt num2str(table{i,j})];
      else
        txt=[txt num2str(table(i,j))];
      endif
      txt=[txt ","];
    endfor
    txt=txt(1:end-1);
    txt=[txt "\n"];
  endfor
  fh=fopen(filename,'w');
  fwrite(fh,txt);
  fclose(fh);
endfunction