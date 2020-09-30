function img=open_partial_image_by_roi(filename,roi,varargin)
dx=0;
dy=0;
split_varargin(varargin);
 I=imfinfo(filename);
 w=I.Width;
 h=I.Height;
roi=translate_roi(roi,dx,dy,[h,w]);
img=imread(filename,"PixelRegion", {[roi(1) roi(2)], [roi(3) roi(4)]});
endfunction
