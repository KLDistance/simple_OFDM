function [output_analog] = RecvFront_Delay(input_analog, sampling_us)
% RecvFront_Delay. Separate orthogonal sinusoidal components
% Specific to least h(t) delay detection

signal_length = length(input_analog);
% wct component
wct = 1E8 * ((1 : signal_length) - 1) ./ signal_length;
% obtain cos and sin coefficients
real_part = 2 * input_analog .* cos(wct);
imag_part = 2 * input_analog .* sin(wct);
complex_analog = real_part + 1j * imag_part;
% low-pass noise eliminate (1/2 * fs according to Nyquist Rate)
base_freq = 1 / (sampling_us * signal_length * 1E-6);
N_cutoff = uint32((1 / sampling_us * 1E6 / 2) / base_freq);
% FFT ideal filtering
fft_filt = [ones(1, N_cutoff), zeros(1, signal_length - 2 * N_cutoff + 1), ones(1, N_cutoff - 1)];
complex_analog_fft = fft(complex_analog);
output_analog = ifft(complex_analog_fft .* fft_filt);

end

