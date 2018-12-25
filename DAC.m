function [ct_signal] = DAC(pulse_chain, elapse_us, sampling_us)
%DAC changes the pulse chain into continuous-time signal
%{
    pulse_chain is the input pulse chain signal in digial mode.
    elapse_us is the signal lasting time for each pulse.
    sampling_us is the time resolution of each point.
%}
% obtain the number of points
pts_num = uint32(elapse_us / sampling_us);
% transform to CT signal
ct_signal = imresize(pulse_chain, [1, length(pulse_chain) * pts_num], 'nearest');
end

