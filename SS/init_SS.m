function init_SS(app)
global state;
global arduino;
global light_value;
global randtable;
global lightval;
global preview_active;
global write_index;
global reward_denied;
global sdata;
global audio_volume;
global run;

run = 0;

audio_volume = 0;
sdata  ={'test'};
reward_denied = 0;
write_index = 1;

% set_backgrounds(app);

tic;

d = uiprogressdlg(app.figure1,'Title','Please Wait', 'Message','Opening the application');
% imaqreset;

preview_active = 0;
% randtable = [0 0 ; 0 1; 1 0; 1 1 ; 1 2; 1 3; 2 0 ; 2 1];
randtable = [0 0 ; 0 1; 1 0; 1 1; 2 0 ; 2 1];

lightval = 1;
light_value = 3;

state = '0';
delete(instrfindall);

devs = fcom();
[r,c] = size(devs);

for i = 1:r
    [str,n] =  devs{i,:};
    if ~isempty(str)
        if contains(string(str),'Arduino') &&  contains(string(str),'Mega')
            break;
        end
    end
end

comstr = ['COM' num2str(n)]; % ,'Mega'];
arduino=serial(comstr,'BaudRate',115200); % create serial communication object on port COM4
arduino.BytesAvailableFcnCount = 3;
arduino.BytesAvailableFcnMode = 'byte';
fopen(arduino); % initiate arduino communication

% wait until data from arduino
while 1
    bav = get(arduino,'BytesAvailable');
    
    if bav > 0
        sdata = fread(arduino,bav);    
        fprintf('init %4.3f %s \n',toc,sdata);   %GL edit added \n to string
    end

    if contains(char(sdata'),'Rset')
        break
    end
end

% sdata = fread(arduino,bav);    
% make sure 'Rset' received
% if ~contains(char(sdata'),'Rset')
%     return;
% end

% start serial reads in background
arduino.BytesAvailableFcn = {'read_serial'};

fprintf(' %s \n',sdata);   %GL edit added \n to string
if 0
% initialize the reward pulse and air puff durations
fprintf(arduino,'%c','q');
fprintf(arduino,'%c',round(str2double(app.reward_pulse_C.Value)));
pause(0.05);
fprintf(arduino,'%c','v');
fprintf(arduino,'%c',round(str2double(app.reward_pulse_L.Value)));
pause(0.05);
fprintf(arduino,'%c','w');
fprintf(arduino,'%c',round(str2double(app.reward_pulse_R.Value)));
pause(0.05);
% fprintf(arduino,'%c','u');
% fprintf(arduino,'%c',round((app.airpuff_duration.Value)));
end

% set audio volume to 0
fprintf(arduino,'%c','t');

close(d);

% init_camera(hObject, eventdata, handles);
