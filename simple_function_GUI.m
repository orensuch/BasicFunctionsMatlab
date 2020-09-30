function params=simple_function_GUI(varargin)
warning off
allow_only_one_instance=1;

#gridX,gridY,name,type,required,default/options cell;
#Types: text,boolean,text_select,num_select
# for text_select or num_select the last element is  
func='test_function_for_simpleGUI';
#func='return';
grid_size_X=150;
grid_size_X_name=150;
grid_size_Y=20;
grid_delta=10;
gui_array={1,1,'var1_text','text',1,'1';...
                     1,2,'var2_text_optional','text',0,'def';...
                     1,3,'var3_bool_optional','boolean',0,1;...
                     1,4,'var2_textselect_optional','text_select',0,{{'abc','def'},1};...
                     1,5,'var2_textselect_optional','num_select',0,{{'abc1','def1'},2};...
                     };
split_varargin(varargin);   

if allow_only_one_instance
try
	close(findall('tag',['simple_GUI_' func '_' num2str(length(varargin))]));
end
endif
pause(0.2);

if ~exist('p','var')
  p=figure;
  set(p,'menubar','none');
   set(p,'name',[func ' simpleGUI']);
   set(p,'numbertitle','off');
	 set(p,'tag',['simple_GUI_' func '_' num2str(length(varargin))]);

endif
                  
k=1;

my=max([gui_array{:,2}])+2;
mx=max([gui_array{:,1}]);

uicontrol('style','text','position',[2*(min([gui_array{:,1}])-1)*grid_size_X+grid_delta*(min([gui_array{:,1}])),(my)*(grid_size_Y+grid_delta),grid_size_X,grid_size_Y],'string',[func ' simpleGUI'],'backgroundcolor',[1,1,1]);
for g=1:size(gui_array,1)
  userdata=struct('required',gui_array{g,5});
  switch  lower(gui_array{g,4})
    case 'text'
      uihan(k,1)=uicontrol('style','text','position',[(gui_array{g,1}-1)*(grid_size_X+grid_size_X_name)+grid_delta*(gui_array{g,1}),(my-gui_array{g,2})*(grid_size_Y+grid_delta),grid_size_X_name,grid_size_Y],'string',gui_array{g,3},'horizontalAlignment','left','backgroundcolor',[1,1,1]);
      uihan(k,2)=uicontrol('style','edit','position',[((gui_array{g,1}))*(grid_size_X+grid_size_X_name)-grid_size_X+grid_delta*(gui_array{g,1}),(my-gui_array{g,2})*(grid_size_Y+grid_delta),grid_size_X,grid_size_Y],'tag',gui_array{g,3},'backgroundcolor',[1,1,1],'string',gui_array{g,6},'userdata',userdata);
      k=k+1;
    case 'boolean'
      uihan(k,1)=uicontrol('style','text','position',[(gui_array{g,1}-1)*(grid_size_X+grid_size_X_name)+grid_delta*(gui_array{g,1}),(my-gui_array{g,2})*(grid_size_Y+grid_delta),grid_size_X_name,grid_size_Y],'string',gui_array{g,3},'horizontalAlignment','left','backgroundcolor',[1,1,1]);
      uihan(k,2)=uicontrol('style','checkbox','position',[((gui_array{g,1}))*(grid_size_X+grid_size_X_name)-grid_size_X+grid_delta*(gui_array{g,1})+(grid_size_X+20)/2 ,(my-gui_array{g,2})*(grid_size_Y+grid_delta),30,grid_size_Y],'tag',gui_array{g,3},'backgroundcolor',[1,1,1],'horizontalalignment','left','value',gui_array{g,6},'userdata',userdata);
      k=k+1;
    case {'text_select','num_select'}
      userdata.mode=gui_array{g,4};
      uihan(k,1)=uicontrol('style','text','position',[(gui_array{g,1}-1)*(grid_size_X+grid_size_X_name)-grid_size_X+grid_delta*(gui_array{g,1}),(my-gui_array{g,2})*(grid_size_Y+grid_delta),grid_size_X_name,grid_size_Y],'string',gui_array{g,3},'horizontalAlignment','left','backgroundcolor',[1,1,1]);
      string_cell=gui_array{g,6}{1};
      userdata.string_cell=string_cell;
      value=gui_array{g,6}{2};
      txt=[];
      for i=1:length(string_cell)
        txt=[txt string_cell{i}];
        if i<length(string_cell)
          txt=[txt '|'];
        endif
      endfor
      uihan(k,2)=uicontrol('style','popupmenu','position',[((gui_array{g,1}))*(grid_size_X+grid_size_X_name)-grid_size_X+grid_delta*(gui_array{g,1}),(my-gui_array{g,2})*(grid_size_Y+grid_delta),grid_size_X,grid_size_Y],'tag',gui_array{g,3},'string',txt,'value',value,'backgroundcolor',[1,1,1],'userdata',userdata);
      k=k+1;
      
endswitch

endfor
  uicontrol('style','pushbutton','position',[((gui_array{g,1})-1)*grid_size_X+grid_delta*(gui_array{g,1}),(my-gui_array{g,2}-1)*(grid_size_Y+grid_delta),grid_size_X,grid_size_Y],'callback',{@run_function,uihan,func},'string','run...');

pos=get(p,'position');
pause(0.1)
refresh(p);
set(p,'position',[pos(1),pos(2),mx*(grid_size_X_name+grid_size_X+grid_delta),my*(grid_size_Y+grid_delta)]);
pause(0.5);
refresh(p);
uiwait

if strcmp(func,'return')
	if ishandle(p)
  params=get(p,'userdata');
  for i=1:size(params,1)
    var=params{i,1};
    value=params{i,2};
    assignin('caller',eval(var),eval(value));
  endfor
else
	params=-1;
	endif
  return
endif

endfunction



function varargout=run_function(han,var2,uihan,func)
    
    evalstr=[func '('];
    for i=1:size(uihan,1)
     userdata=get(uihan(i,2),'userdata');
      params(i,1)={["'" strrep(get(uihan(i,2),'tag'),' ','_') "'"]};
      switch lower(get(uihan(i,2),'style'))
        case 'edit'
          value=get(uihan(i,2),'string');
          if isempty(str2num(value))
            value=["'" value "'"];
          else
            value=["[" value "]"];
          endif
          case 'checkbox'
            value=num2str(get(uihan(i,2),'value'));
            case 'popupmenu'
                  string_cell=userdata.string_cell;
              switch lower(userdata.mode)
                case 'text_select'
                  value=["'" strrep(string_cell{get(uihan(i,2),'value')},' ','_') "'"];
                  case 'num_select'
                  value=num2str(get(uihan(i,2),'value'));
               endswitch
           endswitch
          params(i,2)={value};
          params(i,3)={userdata.required};
        endfor
        

[p,l]=sort([params{:,3}],'descend');
params=params(l,:);
for i=1:size(params,1)
  if p(i)==1;
  evalstr=[evalstr params{i,2}];
 else
    evalstr=[evalstr params{i,1} ',' params{i,2}];
  endif
  if i<length(params)
    evalstr=[evalstr ','];
  endif
endfor
evalstr=[evalstr ');'];
if ~strcmp(func,'return')
uiresume
eval(evalstr);
else
#assignin('caller','gui_output',params)
set(get(han,'parent'),'userdata',params);
uiresume
endif
      
      
endfunction




                  