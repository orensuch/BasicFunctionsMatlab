function save_high_res_image(fh,filename)
if ~ishandle(fh)
		disp('input 1 is not a handle');
		return
	end
	

  print(fh,filename,'-r600','-tight',['-S' num2str(get(fh,'position')([3])) ',' num2str(get(fh,'position')([4]))]);
endfunction
