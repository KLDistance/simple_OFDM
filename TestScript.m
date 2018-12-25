clear;

% set global sampling rate and elapse time for ADC, DACs
sampling_us = 0.01;
DAC_elapse_period_us = 1;
% data symbols
data_symbols = rand(1, 32);
% ifft
symbol_ifft_signal = ifft(data_symbols);
% DAC
symbol_DAC_signal = DAC(symbol_ifft_signal, DAC_elapse_period_us, sampling_us);
% AM
symbol_AM_signal = TransFront(symbol_DAC_signal);
% demodulation
symbol_recv_analog_signal = RecvFront(symbol_AM_signal, sampling_us);
% ADC 
symbol_recv_pulse_chain = ADC(symbol_recv_analog_signal, DAC_elapse_period_us, sampling_us);
% fft
symbol_recv_primitive = fft(symbol_recv_pulse_chain);

figure(1);
subplot(211),stem(data_symbols);
subplot(212),stem(abs(symbol_recv_primitive));