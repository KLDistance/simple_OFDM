function [distort_signal] = ChannelDistortion( ...
    input_signal, ...
    DAC_elapse_period_us, ...
    sampling_us ...
)
% ChannelSimulation. Use a specific example of h(t) to simulate distortion

% e.g. 1 original signal pulse and 3 delay pulses
% test function is 0, 1.5T, 2.5T, 3T
ht_simulation = zeros(1, uint32(DAC_elapse_period_us / sampling_us * 3 + 1));
% set ht pulse at specific point
ht_simulation(1, 1) = 0.5;
ht_simulation(1, uint32(1.5 * DAC_elapse_period_us / sampling_us) + 1) = 0.4;
ht_simulation(1, uint32(2.5 * DAC_elapse_period_us / sampling_us) + 1) = 0.35;
ht_simulation(1, uint32(3 * DAC_elapse_period_us / sampling_us) + 1) = 0.3;
% convolution of pilot with channel signal
distort_signal = conv(input_signal, ht_simulation);

end

