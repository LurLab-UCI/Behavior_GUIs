function control_spouts(s1,s2,app)
global arduino;
global current_servo_position;


if app.servo.Value
    s1 = s1*6;
    s1 = 180 - s1;
    s2 = s2*6;
    temp = 1;
else
    temp = 0;
end

fprintf('%4.3f spouts_%d_%d   \n',toc, (s1),(s2));

fprintf(arduino,'%s',['i' char(s1) temp]); % center
fprintf(arduino,'%s',['j' char(s2) temp]); % sides
current_servo_position = [s1,s2];




