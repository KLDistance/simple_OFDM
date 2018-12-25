function [output_vec] = CPAppend(input_vec, cp_length)
% CPAppend. Add circular prefix

input_vec_length = length(input_vec);
if (cp_length > 0)
    cp_start = input_vec_length - cp_length + 1;
    output_vec = [input_vec(cp_start : input_vec_length), input_vec];
else
    output_vec = input_vec;
end

end
