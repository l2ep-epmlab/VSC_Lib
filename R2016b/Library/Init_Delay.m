%% Compute Control parameters for Output Delay computation 
% i.e. equivalent delay of PWM and controller time step
% Get the mask parameter values. This is a cell
%   array of character vectors.
maskStr = get_param(gcb,'bridge_type');
p=Simulink.Mask.get(gcb);

% The pop-up menu is the first mask parameter.
%   Check the value selected in the pop-up 
if strcmp(maskStr,'Average (no switches)')

    % Set the visibility of both parameters on when 
    %   User-defined is selected in the pop-up.
   % p.getDialogControl('pwm_box').Visible='off';
   % p.getDialogControl('delay_box').Visible='on';
    set_param([gcb '/Bridge_Model/Average'],'Commented','off');
    set_param([gcb '/Bridge_Model/Detailed'],'Commented','on');
    set_param([gcb '/Delay_Choice/delay_discrete'],'Commented','off');
    set_param([gcb '/Delay_Choice/delay_continuous'],'Commented','on');
    %delay_num = str2num(p.getParameter('Output_Delay').Value);
%if isempty(delay_num)
%    delay_num = 0;
%end
    p.getParameter('fpwm').Value = num2str(0.5/2*1/(Output_Delay-Tcontroller));
    Delay_Equivalent = Output_Delay;
    Delay_Flag = 1;
    
elseif strcmp(maskStr,'Detailed (switches included)')

    % Set the visibility of both parameters on when 
    %   User-defined is selected in the pop-up.
    %p.getDialogControl('pwm_box').Visible='on';
    %p.getDialogControl('delay_box').Visible='off';
    set_param([gcb '/Bridge_Model/Average'],'Commented','on');
    set_param([gcb '/Bridge_Model/Detailed'],'Commented','off');
    set_param([gcb '/Delay_Choice/delay_discrete'],'Commented','on');
    set_param([gcb '/Delay_Choice/delay_continuous'],'Commented','off');
    
    p.getParameter('Output_Delay').Value = num2str(Tcontroller+0.5/2*1/fpwm);
    p.getDialogControl('Info_Delay').Prompt = ['Equivalent Output Delay (s) = ', num2str(Tcontroller+0.5/2*1/fpwm)];
    %if (Tcontroller == 0)
    %    Delay_Equivalent = Output_Delay;
    %    Delay_Flag = 2;
    %else
        Delay_Equivalent = Tcontroller;
        Delay_Flag = 2;
    %end
end
