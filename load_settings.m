function load_settings
setting_folder=fileparts(mfilename('fullpath'))
 filehan=fopen([setting_folder '\settings.csv'])
 while 1
   ln=fgetl(filehan)
   if ln==-1
     break
   end
   setting=ln(1:strfind(ln,',')-1)
   value=ln(strfind(ln,',')+1:end)
   if length(str2num(value))==0
     value=["'" value "'"];
   else
     value=num2str(value);
   end
   assignin('caller',setting,eval(value));
 endwhile
 
 fclose(filehan)