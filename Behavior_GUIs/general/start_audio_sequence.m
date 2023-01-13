function start_audio_sequence(app)
global arduino reward_spout;

fprintf(arduino,'%c','a');
audio_volume = app.volume.Value;
fprintf(arduino,'%c',audio_volume);
% fprintf('audio volume = %d \n',audio_volume);


tf = round(str2double(app.TonePitchkHzDropDown.Value));

if app.white_noise.Value
     mbank = 2;
else
    mbank = 1;
end
fprintf(arduino,'%c',['=' tf]);  % skip (for frequency)


ncyc = app.number_of_stim_cycles.Value;
up_ms = round(1000*app.stim_duration.Value);
low_ms =round(1000*(app.stim_cycle_duration.Value - app.stim_duration.Value));

ncycles_l = mod(ncyc,256);
ncycles_h = floor(ncyc/256);

up_l=  mod(up_ms,256); 
up_h =  floor(up_ms/256); 
low_l =  mod(low_ms,256); 
low_h =  floor(low_ms/256); 


switch reward_spout
    case 0  % left
        fprintf(arduino,'%c',['m'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank 10 ]);
    case 1 % right 
        fprintf(arduino,'%c',['n'  up_l up_h low_l low_h ncycles_l ncycles_h  mbank  30]);
end


