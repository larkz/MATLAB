clear all;
clc;
close all;

TSA_A02 = importdata('TSA_A02_60.mat');
TSA_A02 = TSA_A02(1:length(TSA_A02));
TSA_A02 = reshape(TSA_A02, length(TSA_A02), 1);

sample_size = 136;
data_size = 1051;
RMS_byfile = zeros(sample_size, 1);

for i = 1:sample_size
    
    if (i ~= sample_size)
        RMS_byfile(i) = myRMS( TSA_A02( (i-1)*data_size+1:i*data_size));
    else
        RMS_byfile(i) = myRMS( TSA_A02( (i-1)*data_size+1:end));        
    end

end

test_len = 40;
mean40 = mean(RMS_byfile(1:40));
RMS_meansub = RMS_byfile - mean40;

ARmod(RMS_meansub, 1, 40);
ARmod(RMS_meansub, 15, 40);

