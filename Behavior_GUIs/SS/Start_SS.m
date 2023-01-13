function Start_SS(app)
global arduino ack;
global run;
global lrflag;
global ack sdata;
global counter;

lrflag = [];
ack = 0;
% fprintf(arduino,'%c','?');
if app.left.Value
%     fprintf(arduino,'%c',0); % left
    lrflag.a = 1;
    lrflag.v = 1;
elseif app.right.Value
%     fprintf(arduino,'%c',1); % right 
    lrflag.a = 2;
    lrflag.v = 2;
elseif app.center.Value
%     fprintf(arduino,'%c',2); % center
    lrflag.a = 4;
    lrflag.v = 4;
elseif app.simultaneous.Value
%     fprintf(arduino,'%c',3); % all panels
    lrflag.a = 3;
    lrflag.v = 3;
else
    lrflag.a = 1;   % alternating start with ;left
    lrflag.v = 1;   % alternating start with ;left
end
   
run = 1;

%                 volume here ???
fprintf(arduino,'%c','a');
audio_volume = app.audio_volume.Value;
fprintf(arduino,'%c',audio_volume);
fprintf('audio volume = %d \n',audio_volume);

 fprintf(arduino,'%c',['}' round(app.brightness.Value) 0]);
page = 0;
l  = str2double(app.StripeThicknessDropDown.Value);

%  panel mode
if app.full.Value
%     fprintf(arduino,'%c',['+' 4]); %  full panel
    page = 4;
    reinit_light(0);
elseif app.small.Value
%     fprintf(arduino,'%c',['+' 5]); %  small panel
    page = 5;
    reinit_light(0);
elseif app.vert.Value
%     fprintf(arduino,'%c',['+' 2]); %  vert panel
    page = 2;
    reinit_light(l);
elseif app.horz.Value
%     fprintf(arduino,'%c',['+' 6]); %  horz panel
    page = 3;
     reinit_light(l);
elseif app.combo.Value
    reinit_light(l);
    
%     sdata = [];
%     fprintf(arduino,'%c',[';'  l]);
%     t = toc;
%     while ~contains(char(sdata)','ack')
%         pause(0.1);
%                 fprintf('ack = %s \n',sdata);
%     end
%     t-toc
    page = 0;
end
%======= restart counter:
counter = '0';
app.p_count.Text = num2str(counter);


% ====================
if app.visual_only.Value   % Visual only
    visual_only_stimulus(app,lrflag.v,page);
elseif  app.auditory_only.Value   % auditory only
    auditory_only_stimulus(app,lrflag.a);
  else
    visual_and_auditory_stimulus(app,lrflag,page);
end
%         clear page 6
 fprintf(arduino,'%c','@');
            
 
 
function      reinit_light(fl)
 global sdata arduino; 
sdata = [];
fprintf(arduino,'%c',[';'  fl]);
t = toc;
while ~contains(char(sdata)','ack')
    pause(0.001);
%             fprintf('ack = %s \n',sdata);
end
t-toc;
    
