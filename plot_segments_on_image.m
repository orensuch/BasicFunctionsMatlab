function plot_segments_on_image(img,s,varargin)
  segment_plot_length=200;
  segment_offset_y=0;
  segment_axis='x';
  split_varargin(varargin)
  if ~exist('ax','var')
    figure;
    ax=gca;
  endif
  axes(ax);
imshow(img);
hold(ax,'on')
switch lower(segment_axis)
  case 'x'
for i=1:size(s,1);
  plot(ax,[1,1]*s(i,1),size(img,1)/2+segment_offset_y+[-1,1]*segment_plot_length/2,'r');
  plot(ax,[1,1]*s(i,2),size(img,1)/2+segment_offset_y+[-1,1]*segment_plot_length/2,'g');
  plot(ax,[s(i,1),s(i,2)],[1,1]*size(img,1)/2+segment_offset_y,'b')
endfor
case 'y'
for i=1:size(s,1);
  plot(ax,size(img,2)/2+segment_offset_y+[-1,1]*segment_plot_length/2,[1,1]*s(i,1),'r');
  plot(ax,size(img,2)/2+segment_offset_y+[-1,1]*segment_plot_length/2,[1,1]*s(i,2),'g');
  plot(ax,[1,1]*size(img,2)/2+segment_offset_y,[s(i,1),s(i,2)],'b')
endfor
  
  endswitch
endfunction
