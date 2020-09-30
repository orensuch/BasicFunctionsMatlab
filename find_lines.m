function varargout=find_lines(profile,varargin)
  number_of_lines=1e6;
  MinPeakDistance=10;
  MinPeakHeight=0.01;
  is_smooth=1;
  smooth_factor=10;
#  min_height_to_baseline_ratio=1;
max_peak_width=inf;
min_distance_from_start=0;
min_distance_from_end=0;
  is_plot=0;
  split_varargin(varargin); 

  
  D=inf;
  is_found=0;
  nprofile=normalize_array(profile);
	
	p_out=[];
	L_out=[];
	peaksdata_out=[];
	
 for sf=smooth_factor
    if is_found;break;endif
          if is_smooth
          p_profile=smooth(nprofile,sf);
        else
          p_profile=nprofile;
        endif

  for mpd=MinPeakDistance
    if is_found;break;endif
    for mph=MinPeakHeight
      if is_found;break;endif
#      for mn=min_height_to_baseline_ratio
      for mn=max_peak_width
        if is_found;break;endif
##        disp([mpd,mph,sf,mn]);
for mn_ds=min_distance_from_start;        
  if is_found;break;endif
  for mn_de=min_distance_from_end;        
  if is_found;break;endif
        [p,l,peaksdata]=findpeaks(p_profile(1+mn_ds:end-mn_de),'MinPeakDistance',mpd,'MinPeakHeight',mph);
        if isempty(l)
          continue
          end
        l=l+ceil(mn_ds);
        #hb=peaksdata.height./peaksdata.baseline;
   ##     hb=abs(peaksdata.roots(:,1)-peaksdata.roots(:,2));
         hb=[];
         for li=1:length(l);
           l_profile=profile(max(l(li)+round(-mpd/2),1):min(l(li)+round(mpd/2),length(profile)));
           [sigma,mu,A]=gaussfit(1:length(l_profile),l_profile);
           hb(li)=sigma;
         endfor
         
        [hb,s]=sort(hb,"descend");
        p=p(s);l=l(s);
#        N=sum(hb>mn);
        N=sum(hb<mn);
        d=abs(N-number_of_lines);
        if d<D
#          mask=(hb>mn)
          mask=(hb<mn);
          D=d;
          p_out=profile(l(mask));
          l_out=l(mask);
          best_params.d=D;
          best_params.N=N;
          best_params.MinPeakDistance=mpd;
          best_params.MinPeakHeight=mph;
          best_params.max_peak_width=mn;
          best_params.min_distance_from_start=mn_ds;
          best_params.min_distance_from_end=mn_de;
          
          peaksdata_out.baseline=peaksdata.baseline(s)(mask);
          peaksdata_out.height=peaksdata.height(s)(mask);
          peaksdata_out.roots=peaksdata.roots(s,:)(mask,:);
          peaksdata_out.parabol=peaksdata.parabol(s)(mask);
          peaksdata_out.find_lines_detection_params=best_params;
          
        endif
        
        if d==0
          disp(['found exactly ' num2str(N) ' lines']);
          disp(['paramteres: max_peak_width=' num2str(best_params.max_peak_width) ', MinPeakDistance=' num2str(mpd) ', MinPeakHeight=' num2str(mph) ', min_distance_from_start=' num2str(mn_ds) ', min_distance_from_end=' num2str(best_params.min_distance_from_end)]);
          is_found=1;
          if is_plot
            figure;plot(profile);hold on;plot(l_out,p_out,'+');
          endif
          
        endif
      endfor
  endfor
endfor
endfor
endfor
endfor

if ~is_found
try  
          disp(['found ' num2str(length(l_out)) ' lines']);
          disp(['paramteres: max_peak_width=' num2str(best_params.max_peak_width) ', MinPeakDistance=' num2str(best_params.MinPeakDistance) ', MinPeakHeight=' num2str(best_params.MinPeakHeight) ', min_distance_from_start=' num2str(best_params.min_distance_from_start) ', min_distance_from_end=' num2str(mn_de)]);
catch;end;
          endif

  varargout(1)={p_out};
  if nargout>1
  varargout(2)={l_out};
endif
  if nargout>2
  varargout(3)={peaksdata_out};
endif
  if nargout>3
  varargout(4)={D};
endif    
endfunction
