function [output_analog] = RecvFront( ...
    input_analog, ...
    delay_number, ...
    DAC_elapse_period_us, ...
    sampling_us ...
)
% RecvFront. Separate orthogonal sinusoidal components
% Specific to H(jw) detection and X(jw) reconstruction

signal_length = length(input_analog);
% wct component
wct = 1E8 * ((1 : signal_length) - 1) ./ (signal_length - ...
    (DAC_elapse_period_us / sampling_us) * delay_number);
% obtain cos and sin coefficients
real_part = 2 * input_analog .* cos(wct);
imag_part = 2 * input_analog .* sin(wct);
complex_analog = real_part + 1j * imag_part;
% low-pass noise eliminate (use wc)
base_freq = 1 / (sampling_us * signal_length * 1E-6);
N_cutoff = uint32((1E8 / 0.8) / base_freq);
% FFT ideal filtering
fft_filt = [ones(1, uint32(N_cutoff / 2)), zeros(1, signal_length - N_cutoff + 1), ...
    ones(1, uint32(N_cutoff / 2) - 1)];
complex_analog_fft = fft(complex_analog);
output_analog = ifft(complex_analog_fft .* fft_filt);

end

