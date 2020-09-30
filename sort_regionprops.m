function r=sort_regionprops(r,property,direction)
  if ~exist('direction','var')
    direction='ascend';
  endif
  switch lower(property)
    case 'area'
      areas=[r.Area];
      [~,p]=sort(areas,direction);
      case 'x'
        [x,y]=regionprops_to_centers(r);
        [~,p]=sort(x,direction);
        case 'y'
        [x,y]=regionprops_to_centers(r);
        [~,p]=sort(y,direction);
         
        otherwise
          error('select sort property: x, y, area')
  endswitch
  r=r(p);
endfunction
