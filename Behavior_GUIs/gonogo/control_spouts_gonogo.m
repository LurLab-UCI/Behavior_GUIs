function control_spouts_gonogo(s1,fl,app)
global arduino;

if app.disable_center_spout.Value % if  center disabled the return
    return;
end


if fl == 0  % 0 means center
        %center
       if app.servo.Value
            s1 = s1*6;
            s1 = 180 - s1;
           fprintf(arduino,'%s',['i' char(s1) 1]); % center
       else    % linear
           fprintf(arduino,'%s',['i' char(s1) 0]); % center
       end
        fprintf('%4.3f spout_C   %3.1f      \n',toc, (s1));
else  % 
    %sides
    if app.servo.Value
%         s1 = s1*6;
%         s1 = 180 - s1;
       s1 = s1*6;
       fprintf(arduino,'%s',['j' char(s1) 1]); % sides
   else  % linear
       fprintf(arduino,'%s',['j' char(s1) 0]); % sides
   end
   fprintf('%4.3f spouts_LR   %3.1f      \n',toc, (s1));
end



