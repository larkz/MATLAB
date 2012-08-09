function [all_RMS] = RMS_all(Resid4M, data_size, num_teeth)

full_length = length(Resid4M); % 212505

num_sample = floor(full_length/data_size); %136
sample_size = floor(data_size/num_teeth); %22

% Looping through each row, make 136 samples for each corresponding gear
% teeth 1-46:


    RMS_array = zeros( 2 ,num_sample);
    RMS_array(1,:) = 1:num_sample;

    all_RMS = cell(1,num_teeth);

    for i = 1:num_teeth
        all_RMS{i} = RMS_array;
    end

    for s = 1:num_sample %93

        extract_data = Resid4M( (s-1)*data_size + 1 : s*data_size);

        for c = 1:num_teeth %70

            RMS_val = myRMS(extract_data(sample_size*(c-1) + 1: sample_size*c ));
            all_RMS{c}(2,s) = RMS_val;

        end

    end
    
