function [pulse_chain] = ADC(ct_signal, elapse_us, sampling_us)
% ADC. Change the continuous-time signal into digital signal
%{
    notice: no loss of pineer receipt data during sampling is in the 
    preassuption. If it indeed happens, the sequence and samples in 
    the data have to be designed to let the restoration process keep 
    intact and in order.
%}

% obtain the number of points
pts_num = uint32(elapse_us / sampling_us);
% compress the samples to pulses
pulse_length = uint32(length(ct_signal) / pts_num);
pulse_chain = zeros(1, pulse_length);
for iter = 1 : pulse_length
    % temp index variable of every first element of T
    tmp_iter_bdl = (iter - 1) * pts_num + 1;
    % sampling and mean value
    pulse_chain(1, iter) = mean(ct_signal(tmp_iter_bdl : tmp_iter_bdl + pts_num - 1));
end

end

