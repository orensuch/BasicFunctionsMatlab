function r=mask_regionprops(r,varargin)
  min_area=0;
  max_area=inf;
  X=0;
  TolX=0;
  minX=-inf
  maxX=+inf;
  Y=0;
  TolY=0;
  minY=-inf;
  maxY=+inf;
  min_circularity=0;
  max_circularity=1;
  
  split_varargin(varargin)
  
  r=r([r.Area]>=min_area);
  r=r([r.Area]<=max_area);
  [x,y]=regionprops_to_centers(r);
  r=r((x>=minX)&(x<=maxX));
  [x,y]=regionprops_to_centers(r);
  r=r((y>=minY)&(y<=maxY));
  [x,y]=regionprops_to_centers(r);
  
  if ((abs(X)>0)|(TolX>0))
    r=r(abs(x-X)<TolX);
  endif
  if ((abs(Y)>0)|(TolY>0))
    r=r(abs(y-Y)<TolY);
  endif
  
  if ((min_circularity>0)|(max_circularity<1))
     circ=([r.MinorAxisLength]./[r.MajorAxisLength]);
      r=r((circ>=min_circularity)&(circ<=max_circularity));
    endif
    
  
endfunction
