function out=normalize_array(array)
  if strcmp(class(array),'uint8')
    array=double(array);
  endif
  if strcmp(class(array),'uint16')
    array=double(array);
  endif
  
  array=array-min(array(:));
  out=array./max(array(:));
endfunction
