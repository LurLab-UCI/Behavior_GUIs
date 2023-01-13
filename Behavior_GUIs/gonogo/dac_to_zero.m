function dac_to_zero(a,~,app)

% catch trial dac to zero
global arduino

stop(a);
delete(a);
clear a;

if app.visual_active_go.Value
%                 write 000 to  quad dac ch C
      fprintf(arduino,'%c',['c' 2  0 0]);
else
%                 write 0 to single dac
      fprintf(arduino,'%c',['g' 0]);
end

fprintf('%3.3f  dac to zero\n',toc);

