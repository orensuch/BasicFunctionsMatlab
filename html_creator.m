classdef html_creator <handle

properties
  filename
  file_handle
  html=""
endproperties

methods
  
  function obj=html_creator(filename)
    if exist('filename')
    obj.filename=filename;
  end
  endfunction
  
  function clear(obj)
    obj.html="";
  endfunction

  
  function add(obj,html_txt);
    obj.html=[obj.html html_txt]; 
  endfunction 
  
  function html_txt=begin_html(obj)
    %obj.clear
    html_txt=["<html>\n<body>\n"];
    %obj.html=html_txt
  endfunction
  
  
  function html_txt=header(obj,txt,level)
    if ~exist('level')
      level=1;
    endif
    html_txt=["<h" num2str(level) ">" txt "</h" num2str(level) ">\n"];
    %obj.html=[obj.html html_txt]; 
  endfunction

   function html_txt=paragraph(obj,txt)
    html_txt=["<p>"  txt "</p>\n"];
    %obj.html=[obj.html html_txt]; 
  endfunction
  
  
   function html_txt=picture(obj,img_name,width)
     if ~exist('width')
       width="600"
     else
       if ~(width>1)
         width=[num2str(floor(100*width)) '%'];
       end
     end
    html_txt=[ "<a href="""  img_name " ""target=""_blank""><img src=""" img_name """ width=""" num2str(width) """ ></a>\n"];
    %obj.html=[obj.html html_txt]; 
  endfunction
  
   function html_txt=table(obj,tabledata,width,padding)
     if ~exist('width')
       width="100%"
     else
       if ~(width>1)
         width=[num2str(floor(100*width)) '%'];
       end
     end
    html_txt=["<table style=""width:" num2str(width) """ border=""1"">\n"];
    for i=1:size(tabledata,1)
      html_txt=[html_txt "<tr>\n "];
      for j=1:size(tabledata,2)
         html_txt=[html_txt '<th padding="15px">'  num2str(tabledata{i,j}) '</th>'];
      endfor
      html_txt=[html_txt "</tr>\n "];
    endfor
    html_txt=[html_txt "</table>\n" ];
    
    %obj.html=[obj.html html_txt]; 
  endfunction
  

function html_txt=end_html(obj)
    html_txt=["</body>\n</html>\n"];
    %obj.html=[obj.html html_txt]; 
  endfunction
  
  function write_file(obj)
   if isempty(obj.filename)
     disp('flename is not defined. using default filename')
     obj.filename='html_file.html'
   end 
   fh=fopen(obj.filename,'w');
   fwrite(fh,obj.html);
   fclose(fh);
   endfunction
  
  endmethods

endclassdef