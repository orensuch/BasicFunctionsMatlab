function out_img=crop_region_by_roi(img,roi)
  if isempty(roi)
    out_img=-1;
    return
  end
  out_img=img(roi(1):min(size(img,1),roi(2)),roi(3):min(size(img,2),roi(4)),:);
endfunction
