function [symbol_recv] = OFDMTrans( ...
    data_symbols, ...
    delay_number, ...
    extra_cp_number, ...
    ht_coeff, ...
    DAC_elapse_period_us, ...
    sampling_us ...
)
% OFDMTrans. Generate FD-based TD-form digital signals against ISI based on
% OFDM CP and coefficients estimation
% ifft
symbol_ifft_signal = ifft(data_symbols);
% add cp
symbol_cp_signal = CPAppend(symbol_ifft_signal, delay_number + extra_cp_number);
% DAC
symbol_DAC_signal = DAC(symbol_cp_signal, DAC_elapse_period_us, sampling_us);
% AM
symbol_AM_signal = TransFront(symbol_DAC_signal);
% channel distortion
symbol_channel_signal = ChannelDistortion(symbol_AM_signal, DAC_elapse_period_us, sampling_us);
% demodulation
symbol_recv_analog_signal = RecvFront(symbol_channel_signal, delay_number, DAC_elapse_period_us, sampling_us);
% ADC 
symbol_recv_pulse_chain = ADC(symbol_recv_analog_signal, DAC_elapse_period_us, sampling_us);
% remove cp
symbol_cp_eliminate = CPRemove(symbol_recv_pulse_chain, delay_number + extra_cp_number);
% remove delay suffix
symbol_delay_eliminate = symbol_cp_eliminate(1, 1 : (length(symbol_cp_eliminate) - delay_number));
% fft
symbol_recv_primitive = fft(symbol_delay_eliminate);
% reconstruct using ht' coefficients
symbol_recv = symbol_recv_primitive ./ ht_coeff / 32;
end
