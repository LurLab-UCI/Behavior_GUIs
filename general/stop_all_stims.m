function stop_all_stims()

global arduino;
fprintf(arduino,'%c',[':' ]);  % stops all lights and audio
