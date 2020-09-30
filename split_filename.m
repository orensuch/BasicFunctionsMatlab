function [folder,name,ext]=split_filename(filename)
slashes=findstr (filename,'\');
if isempty(slashes)
  last_slash=1;
  folder='';
else
  last_slash=slashes(end);
  folder=filename(1:last_slash);
end
dots=findstr(filename,'.');
if isempty(dots)
  last_dot=length(filename);
  name=filename(last_slash+1:last_dot);
  ext='';
else
  last_dot=dots(end);
name=filename(last_slash+1:last_dot-1);
ext=filename(last_dot+1:end);
  end
