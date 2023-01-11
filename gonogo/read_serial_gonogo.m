function read_serial_gonogo(obj,~)
global sdata lick_detected no_response_timer;

bav = get(obj,'BytesAvailable');
if bav > 0
    sdata = fread(obj,bav);    
    fprintf('%4.3f  %s \n',toc,sdata);   %GL edit added \n to string
%     if contains(char(sdata'),'ack')
%         ack = 1
%     end
     if contains(char(sdata'),'lcC')
         lick_detected = 1;
      end

end