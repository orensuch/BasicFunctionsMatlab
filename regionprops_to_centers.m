function [X,Y]=regionprops_to_centers(r)
   centers=reshape([r.Centroid],2,length(r));
  X=centers(1,:);
  Y=centers(2,:);
endfunction
