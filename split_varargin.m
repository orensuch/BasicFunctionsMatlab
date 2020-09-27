function vars=split_varargin(v)
if isempty(v)
  vars=-1;
  return 
end

try
if isempty(v{1,1})
  vars=-1
  return
endif
catch;end_try_catch


  k=1;
  
  for i=1:2:length(v)
    var=v{i};
    vars(k)={var};
    k=k+1;
    value=v{i+1};
    if ~isempty(value)
    assignin('caller',var,value);
  end
  
  endfor
  
  if ~exist('vars')
    vars=-1;
  endif
endfunction
