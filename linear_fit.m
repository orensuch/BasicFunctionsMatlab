function [a,b]=linear_fit(x,y)
  if size(x,1)<size(x,2)
    x=x';
  endif
  
  if ~exist('y','var')
    y=x;
    x=[1:length(x)]';
endif
  
  if size(y,1)<size(y,2)
    y=y';
  endif
  
    
  X = [ones(length(x), 1) x];
  theta = (pinv(X'*X))*X'*y;
  a=theta(2);
  b=theta(1);
  
endfunction
