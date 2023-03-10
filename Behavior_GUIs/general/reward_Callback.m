% --- Executes on button press in reward1.
function reward_Callback(app,str)
% hObject    handle to reward1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;
global lightval;
global reward_denied;

% if reward_denied && app.training_reward.Value
if reward_denied && (rand  >  (app.percent_retrial_rewards.Value)/100 )
        fprintf('%4.3f reward denied \n',toc);
   return; 
end
switch str
    case 'R'
        fprintf(arduino,'%c','x');  %right
        fprintf('%4.3f reward_R \n',toc);
    case 'L'
        fprintf(arduino,'%c','y'); %left
        fprintf('%4.3f reward_L \n',toc);
    case 'C'
        fprintf(arduino,'%c','z'); % center
        fprintf('%4.3f reward_C \n',toc);
end


