function varargout=find_perimeter(img_bw,varargin)
  is_plot=1;
  split_varargin(varargin);
  bwp=bwperim(img_bw);
  [X,Y]=meshgrid([1:size(bwp,2)],[1:size(bwp,1)]);
  xa=X(bwp);
  ya=Y(bwp);
bwp_mask=1:length(xa);
x_in=xa(bwp_mask);
y_in=ya(bwp_mask);
xi=x_in(1);
yi=y_in(1);
i=2;

x=x_in(2:end);
y=y_in(2:end);
x_out=xi;
y_out=yi;

while 1
  if i==(length(x_in)-1)
    break
  end
  
  D=sqrt((xi-x).^2+(yi-y).^2);
  D(D==0)=inf;
  [m,d]=min(D);
  x_out(i)=x(d);
  y_out(i)=y(d);
  i=i+1;
  xi=x(d);
  yi=y(d);
  mask=1-([1:length(x)]==d);
  x=x(mask>0);
  y=y(mask>0);
endwhile  
dis=sqrt((x_out(1:end-1)-x_out(2:end)).^2+(y_out(1:end-1)-y_out(2:end)).^2);
perim_length=sum(dis(dis<1.5));

if is_plot
figure;
imshow(img_bw);
hold on;
plot(x_out,y_out,'.r');
endif

if nargout>0;
  varargout(1)={perim_length};
endif

if nargout>1;
  varargout(2)={[x_out;y_out]};
endif

 

