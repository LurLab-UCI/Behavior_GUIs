function duration = start_audio_sequence_go(app)
global arduino ;
global dac_val_audio;

fprintf(arduino,'%c','a');
audio_volume = app.audio_volume_go.Value;
fprintf(arduino,'%c',audio_volume);

if 0
% write to dac C
dac_val = 1000;
dl = mod(dac_val,256);
dh = floor(dac_val/256);
fprintf(arduino,'%c',['c'  2 dl dh]);
end

tf = round(str2double(app.audio_tone_pitch_go.Value));

if strfind(app.audio_stimulus_type_go.Value,'noise');
     mbank = 2;
else
    mbank = 1;
end
fprintf(arduino,'%c',['=' tf]);  % skip (for frequency)


ncyc = round(app.audio_stimulation_frequency_go.Value*app.audio_stimulus_duration_go.Value/1000);
up_ms = round(1000/app.audio_stimulation_frequency_go.Value);
low_ms = up_ms;

duration = ncyc*(up_ms + low_ms)/1000;

ncycles_l = mod(ncyc,256);
ncycles_h = floor(ncyc/256);

up_l=  mod(up_ms,256); 
up_h =  floor(up_ms/256); 
low_l =  mod(low_ms,256); 
low_h =  floor(low_ms/256); 

if app.stimulus_side_left_go.Value    
%     case 0  % left + dac val
        fprintf(arduino,'%c',['m'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank dac_val_audio.go_L ]);
else
%     case 1 % right  + dacval
        fprintf(arduino,'%c',['n'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  dac_val_audio.go_R ]);
end


