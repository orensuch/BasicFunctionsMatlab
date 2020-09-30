function varargout=match_regionprops(R,R_ref,varargin)
  #R_matched=match_regionprops(R,R_ref,varargin)
  #[R_matched,index_order]=match_regionprops(R,R_ref,varargin)
  #[R_matched,index_order,min_difference_at_matching]=match_regionprops(R,R_ref,varargin)
  weights=[1,1,1];
  split_varargin(varargin);
  [x_ref,y_ref]=regionprops_to_centers(R_ref);
  area_ref=[R_ref.Area];
  [x,y]=regionprops_to_centers(R);
  area=[R.Area];
  
  for i=1:length(R_ref)
    d=sqrt((weights(1)*(x-x_ref(i))).^2+(weights(2)*(y-y_ref(i))).^2+weights(3)*abs(area-area_ref(i)));
    [m(i),p(i)]=min(d);
  endfor
  r=R(p);
  
    varargout(1)={r};
  if nargout>1
    varargout(2)={p};
  endif
  if nargout>2
    varargout(3)={m};
  endif
  
  
  
endfunction
