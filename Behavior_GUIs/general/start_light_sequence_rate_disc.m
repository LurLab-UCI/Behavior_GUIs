function start_light_sequence_rate_disc(app,dac_val)
global arduino rate;
global  single_panel_rate;


% get rates
    
if app.single_panel.Value

%     if app.higher_rate_correct.Value
%         if reward_spout == 0 % left
%             rte = rate.l;
%         else
%             rte = rate.r;
%         end
%     else
%         if reward_spout == 0 % left
%             rte = rate.r;
%         else
%             rte = rate.l;
%         end
%     end
    
    rte =  single_panel_rate;

    fprintf('%3.3f   stim rate  = %2.2f \n',toc,rte);

    % center
    ncyc  = round(rte * app.stim_duration_rate_disc.Value);
    ncycles_l = mod(ncyc,256);
    ncycles_h = floor(ncyc/256);
    up_ms  = round(1000/rte/2);
    low_ms = up_ms;
    up_l=  mod(up_ms,256); 
    up_h =  floor(up_ms/256); 
    low_l =  mod(low_ms,256); 
    low_h =  floor(low_ms/256); 
    panel = 4;
    fprintf(arduino,'%c',['&'  up_l up_h low_l low_h ncycles_l ncycles_h  panel dac_val ]);

else

    % left
    ncyc  = round(rate.l * app.stim_duration_rate_disc.Value);
    ncycles_l = mod(ncyc,256);
    ncycles_h = floor(ncyc/256);
    
    up_ms  = round(1000/rate.l/2);
    low_ms = up_ms;
    up_l=  mod(up_ms,256); 
    up_h =  floor(up_ms/256); 
    low_l =  mod(low_ms,256); 
    low_h =  floor(low_ms/256); 
    panel = 4;
    fprintf(arduino,'%c',['b'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val]);

    % right
    ncyc  = round(rate.r * app.stim_duration_rate_disc.Value);
    ncycles_l = mod(ncyc,256);
    ncycles_h = floor(ncyc/256);
    up_ms  = round(1000/rate.r/2);
    low_ms = up_ms;
    up_l=  mod(up_ms,256); 
    up_h =  floor(up_ms/256); 
    low_l =  mod(low_ms,256); 
    low_h =  floor(low_ms/256); 
    panel = 4;
    fprintf(arduino,'%c',['+'  up_l up_h low_l low_h ncycles_l ncycles_h  panel  dac_val]);
end
% 
