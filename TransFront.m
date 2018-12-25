function [output_analog] = TransFront(input_analog)
%TransFront Combine the real and imag part together

wct = 1E8 * ((1 : length(input_analog)) - 1) ./ length(input_analog);
output_analog = real(input_analog) .* cos(wct) + imag(input_analog) .* sin(wct);

end

