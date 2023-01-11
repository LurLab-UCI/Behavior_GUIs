function read_serial(obj,event)
global sdata ack;

bav = get(obj,'BytesAvailable');
if bav > 0
    sdata = fread(obj,bav);    
    fprintf('%4.3f  %s \n',toc,sdata);   %GL edit added \n to string
%     if contains(char(sdata'),'ack')
%         ack = 1
%     end
end