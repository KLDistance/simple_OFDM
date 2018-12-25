function [output_vec] = CPRemove(input_vec, cp_length)
% CPRemove. Remove circular prefix

output_vec = input_vec;
output_vec(1 : cp_length) = [];

end

