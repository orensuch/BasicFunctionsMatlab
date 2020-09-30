function [segments_x,segments_y,found_params]=find_optimal_segmentation(img,expected_x,expected_y,varargin)
  ## Defaults:
  tic
  filter_type='erode';
  filter_parameters(1)={strel('diamond',2)};
  filter_x=30;
  filter_y=45;
  min_y_segment_size=1/8;
  min_x_segment_size=1/13;
  gamma=1;
  in_low=0;
  in_high=1;
  use_derivative_for_segmentation=0;
  pkg load image
  split_varargin(varargin);
  
  segments_x=[];
  segments_y=[];
  dif_segments=inf;
  dif_tmp_segments=[];
  disp('Searching for optimal segmentation')
  found_params.filter_type=filter_type;
 
    for il=1:length(in_low)
      for ih=1:length(in_high)
        if in_low(il)>=in_high(ih)
          continue
        end
    for g=1:length(gamma)       
    try
    adjusted_img=imadjust(img,[in_low(il),in_high(ih)],[0,1],gamma(g));
    disp(sprintf('image adjustment parameters: in_low=%1.1f, in_high=%1.1f, gamma=%2.1f',in_low(il),in_high(ih),gamma(g)));
  catch
    disp('failed to adjust image');
    continue
  end
  
  for el=1:length(filter_parameters)
    switch filter_type
      case 'erode'
    img_erode=imerode (adjusted_img,filter_parameters{el});
    img_for_segmentation=double(img_erode);
    endswitch
    
     for d=1:length(use_derivative_for_segmentation)
    use_diff=use_derivative_for_segmentation(d);

    for fx=1:length(filter_x)
      for fy=1:length(filter_y)  
        if dif_tmp_segments==0
          disp(sprintf('%1.0f X segments and %1.0f Y segments found in %3.0f seconds (filter type %2.0f, filter x: %2.0f,  filter y: %2.0f),',expected_x,expected_y,round(toc),el,filter_x(fx),filter_y(fy)))
          if use_diff
            disp('Derivatave was used for segmentation')
          end
          
          segments_x=segments_x_tmp;
          segments_y=segments_y_tmp;
          return
        endif 
        
        y_profile=normalize_array(sum(img_for_segmentation,2));
        x_profile=normalize_array(sum(img_for_segmentation,1));
        if use_diff
          x_profile=abs(diff(x_profile ));
          y_profile=abs(diff(y_profile ));
        end
        
        segments_y_tmp=find_segments(y_profile,'min_segment_size',size(img_for_segmentation,1)*min_y_segment_size,'filter_size',filter_y(fy));
        segments_x_tmp=find_segments(x_profile,'min_segment_size',size(img_for_segmentation,2)*min_x_segment_size,'filter_size',filter_x(fx));
        dif_tmp_segments=abs((size(segments_x_tmp,1)-expected_x))+abs((size(segments_y_tmp,1)-expected_y));
        dif_segments=abs((size(segments_x,1)-expected_x))+abs((size(segments_y,1)-expected_y));
        
        if dif_segments>dif_tmp_segments
          segments_x=segments_x_tmp;
          segments_y=segments_y_tmp;
        endif 
           found_params.filter_x=filter_x(fx);
          found_params.filter_y=filter_y(fy);
          found_params.filter_parameters=filter_parameters(el);
          found_params.filter_parameters_index=el;
          found_params.gamma=gamma(g);
          found_params.in_low=in_low(il);
          found_params.in_high=in_high(ih);
          found_params.use_derivative_for_segmentation=use_diff;
          
      endfor %fy
    endfor %fx
  endfor %el
  endfor %use derivative
endfor %in_low
endfor %in_high
  endfor %gamma
  
endfunction
