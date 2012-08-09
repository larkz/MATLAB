close all;
clear;
clc;
clear all;

% cut off 135 data points

% Import data in cell format
SigData = importdata('Run10SignatureA02_Data.mat');

mesh_freq = 1051;

n = length(SigData{1});

SigDataAvg = zeros(n, 1);
avg_size = 60;

 for c = 1:n
     
     for i = 1:avg_size
         SigDataAvg(c) = SigData{i}(c) + SigDataAvg(c); 
     end
 end
 
SigDataAvg = SigDataAvg/avg_size;

[pks,locs] = findpeaks(SigDataAvg,'minpeakdistance',600);
pks_diff = zeros(length(pks) - 1, 1); 

for i = 1:length(pks_diff)
    pks_diff(i) = locs(i+1) - locs(i); 
end

stdev_peak = std(pks_diff)
mean_peak = mean(pks_diff)

SigDataCont = importdata('SigDataCont.mat');
font_size = 16;


%figure 1
figure('name', ' Raw Vibration Signal Data Collected File #3 (A02)', ... 
                'units','normalized','position', [1.01 .45  .99 .45]);
plot(SigData{3}(1:10000), 'Color',[0.5 0.5 0.5]);
title('Unprocessed file number #3', 'fontsize', font_size, 'FontWeight','bold');
xlabel('Data Point');
ylabel('Signautre Amplitude');


% figure 2
ybounds = ylim;
figure('name', ' Average of 60 Time Synchronous files 1-60 ', ... 
                'units','normalized','position', [1.01 -0.12  0.99 .45]);
plot(SigDataAvg(1:10000), 'Color',[0.5 0.5 0.5]);
title(' Average of 60 Time Synchronous files 1-60 ','fontsize', font_size,  'FontWeight','bold');
xlabel('Data Point');
ylabel('Signautre Amplitude');            
ybounds = ylim; % reset the ybounds

for c = 1:10 %length(locs)
    hold on;
    line([locs(c),locs(c)],[ybounds(1),ybounds(2)], 'Color',[.01 .2 .01])
end

% figure 3
figure('name', ' Raw Vibration Signal Data Collected File #3 (A02)', ... 
                'units','normalized','position', [1.01 .45  .99 .45]);
plot(SigData{3}, 'Color', [0.5 0.5 0.5]);
title('Unprocessed file number #3', 'fontsize', font_size, 'FontWeight','bold');
xlabel('Data Point');
ylabel('Signautre Amplitude');

% figure 4
ybounds = ylim;
figure('name', ' Average of 60 Time Synchronous files 1-60 ', ... 
                'units', 'normalized','position', [1.01 -0.12  0.99 .45]);
plot(SigDataAvg, 'Color', [0.5 0.5 0.5]);
title(' Average of 60 Time Synchronous files 1-60 ', 'fontsize', font_size,  'FontWeight','bold');
xlabel('Data Point');
ylabel('Signautre Amplitude');            
ybounds = ylim; % reset the ybounds

for c = 1:length(locs)
    hold on;
    line([locs(c),locs(c)],[ybounds(1),ybounds(2)], 'Color',[.01 .2 .01])
end

TSA_avg = zeros(mesh_freq, 1);
TSA_avg_cont = zeros(length(TSA_avg)*length(SigData), 1);
Raw_SigData = zeros(length(SigData)*length(SigData{1}) , 1);
sigdatalen = length(SigData);

for x = 1:sigdatalen
    Raw_SigData( (x - 1)*200000 + 1 : x*200000 ) =  SigData{x};
end

% for k = 1:length(SigData)
%     
%     TSA_avg = zeros(mesh_freq, 1);
%     add_count = 0;
%     for i = 3:length(locs)
%  
%         if ( abs(abs(locs(i) - locs(i-1) ) - abs( locs(i-1)-locs(i-2)))   < stdev_peak )
%   
%             TSA_avg = TSA_avg + SigData{k}(locs(i-2):locs(i-2) + mesh_freq - 1)
%             add_count = add_count+1;
%         
%         end
%     
%     end
%     TSA_avg = TSA_avg/add_count;
%     TSA_avg_cont( (k-1)*mesh_freq+1 : k*mesh_freq  ) = TSA_avg;
%     figure();
%     
%     plot(TSA_avg_cont);
% end
% 
% figure();
% plot(TSA_avg_cont);
