function [random_pulse] = RandomPulseChain(chain_length, number_interval)
%RandomPulseChain. Generate random pulse chain within a specific interval

if(length(number_interval) ~= 2)
    random_pulse = [];
else
    random_pulse = unidrnd(number_interval(1, 2), 1, chain_length) + number_interval(1, 1) - 1;
end

end

