function [ht_coefficients] = OFDMEstimate_Coeff( ...
    pilot_pulse, ...
    delay_number, ...
    extra_cp_number, ...
    DAC_elapse_period_us, ...
    sampling_us ...
)
% OFDMEstimate_Coeff. Estimate the coefficients of h(t)
% ifft
pilot_ifft_signal = ifft(pilot_pulse);
% add cp
pilot_cp_signal = CPAppend(pilot_ifft_signal, delay_number + extra_cp_number);
% DAC
pilot_DAC_signal = DAC(pilot_cp_signal, DAC_elapse_period_us, sampling_us);
% AM
pilot_AM_signal = TransFront(pilot_DAC_signal);
% channel distortion
pilot_channel_signal = ChannelDistortion(pilot_AM_signal, DAC_elapse_period_us, sampling_us);
% demodulation
pilot_recv_analog_signal = RecvFront(pilot_channel_signal, delay_number, DAC_elapse_period_us, sampling_us);
% ADC
pilot_recv_pulse_chain = ADC(pilot_recv_analog_signal, DAC_elapse_period_us, sampling_us);
% remove cp
pilot_cp_eliminate = CPRemove(pilot_recv_pulse_chain, delay_number + extra_cp_number);
% remove delay suffix
pilot_delay_eliminate = pilot_cp_eliminate(1 : (length(pilot_cp_eliminate) - delay_number));
% fft
pilot_recv = fft(pilot_delay_eliminate);
% extract coefficients from random pilot
ht_coefficients = pilot_recv ./ pilot_pulse / 32;
end

