machine=1 %1-NeraD, 2-NeraD+,3-NeraV, 4-GPi

clear data titles
#folder='C:\Users\orens\Documents\Projects\FS2\ATP - JM'
[filename folder]=uigetfile('*.csv')
[~,input_filename,~]=split_filename([folder filename])
%input_filename='PQ_report.csv';
output_filename=[input_filename '.sql'];
fn=fopen([folder input_filename '.csv']);
titles=strsplit(fgetl(fn),',');
for t=1:length(titles)
  if strfind(titles{t},'[')&strfind(titles{t},']')
    str=titles{t};
    
    titles(t)={strrep(str,str(strfind(str,'['):max(strfind(str,']'),length(str))),'')}
  endif
endfor


titles(end+1)='passes';
titles(end+1)='Resolution';
titles(end+1)='pinning parameters';
titles(end+1)='pre-heat type';
titles(end+1)='Machine'
titles(end+1)='Direction'
ln=0;
k=1;
data={};
while 1
  ln=fgetl(fn);
  if (ln==-1)
    break
    end
  q=findstr(ln,',');
  q=[0,q,length(ln)]
  ln_data={};
  idx=1;
  for i=1:length(q)-1
   data(k,idx)={ln(q(i)+1:q(i+1)-1)};
   idx=idx+1;
  end 
  
  k=k+1
  end

sql_pre='INSERT INTO PQ_report ('
for i=1:length(titles)
  tlt=strrep(titles{i},'.','');
  tlt=strrep(tlt,'[','_');
  tlt=strrep(tlt,']','_');
  sql_pre=[sql_pre '[' tlt '],'];
end
sql_pre=[sql_pre(1:end-1) ') VALUES (']
  sql_txt='';
  for i=1:size(data,1)
    ie=1-cellfun('isempty',data(i,:));
    if sum(ie)==0
      disp('empty')
      continue
      end
    sql_txt=[sql_txt sql_pre]
    for j=1:size(data,2)
      value=data{i,j};
      if isempty(value)
        sql_txt=[sql_txt 'NULL,'];
        continue
      endif
      
      if isempty(str2num(value))
        sql_txt=[sql_txt "'" data{i,j} "',"];
        else
    sql_txt=[sql_txt num2str(data{i,j}) ','];
    end
  endfor
  filename=data{i,1};
 [passes resolution pinning]=parse_filename(filename);
  sql_txt=[sql_txt num2str(passes) ',' num2str(resolution) ',' num2str(pinning) ',4,' num2str(machine) ",'Bi');\n"];
  endfor


  out=fopen([folder '\' output_filename],'w')
  fwrite(out,sql_txt)
  fclose(out)