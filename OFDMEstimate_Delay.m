function [estimate_delay_number] = OFDMEstimate_Delay( ...
    pilot_pulse, ...
    DAC_elapse_period_us, ...
    sampling_us ...
)
% OFDMEstimate. Estimate the delay number of the system

% for cp estimation of h(t), there is no need to take ifft and fft into
% consideration
% DAC
pilot_DAC_signal = DAC(pilot_pulse, DAC_elapse_period_us, sampling_us);
% AM
pilot_AM_signal = TransFront(pilot_DAC_signal);
% channel distortion
pilot_channel_signal = ChannelDistortion(pilot_AM_signal, DAC_elapse_period_us, sampling_us);
% demodulation
pilot_recv_analog_signal = RecvFront_Delay(pilot_channel_signal, DAC_elapse_period_us, sampling_us);
% ADC
pilot_recv_pulse_chain = ADC(pilot_recv_analog_signal, DAC_elapse_period_us, sampling_us);
% detect cp number
nonzero_recv_pilot_pulse = pilot_recv_pulse_chain(abs(pilot_recv_pulse_chain) > 1E-3);
estimate_delay_number = length(nonzero_recv_pilot_pulse) - 1;

end
