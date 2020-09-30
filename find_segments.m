function segments=find_segments(data,varargin)
is_plot=0;
min_segment_size=1;
filter_size=40;
split_varargin(varargin);


segments=[];

  if size(data,2)==1;
    data=data';
  end
  
pkg load image
pkg load data-smoothing
blobs=(normalize_array(exp(exp(exp(exp(imfilter((data),fspecial('average', [1 filter_size])))))))<0.1);
start_segments=find(diff(blobs)==1);
end_segments=find(diff(blobs)==-1);
if isempty(start_segments)||isempty(end_segments)
  segments=[];
  return
endif

if  start_segments(1)>end_segments(1)
  end_segments=end_segments(2:end);
endif

k=1;
for i=1:min(length(start_segments),length(end_segments))
  start_seg=start_segments(i);
  end_seg=end_segments(i);
  if (end_seg-start_seg)>min_segment_size
  segments(k,1)=start_seg;
  segments(k,2)=end_seg;
  k=k+1;
endif
endfor

if size(segments,2)==1;
    segments=segments';
end

if is_plot
  figure;
  plot(normalize_array(data),'b');
  hold on
  plot(blobs,'y.-.')
  for k=1:size(segments,1)
    plot(segments(k,1)*[1,1],[0.1,0.9],'g');
    plot(segments(k,2)*[1,1],[0.1,0.9],'r');
  endfor
endif
