function roi=extend_roi(roi,px,image_size)
  roi(1)=max(roi(1)-px,1);
  roi(3)=max(roi(3)-px,1);
  roi(2)=min(roi(2)+px,image_size(1));
  roi(4)=min(roi(4)+px,image_size(2));
  
endfunction
