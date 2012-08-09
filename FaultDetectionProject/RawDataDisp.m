clear;
clc;
close all;

SigDataCont = importdata('SigDataCont.mat');
TSA_A02_Data = importdata('TSA_A02_60.mat');

font_size = 15;

figure('name', ' Raw Vibration Signal Data Collected until Failure (A02)', ... 
                'units','normalized','position', [.03 .50  .93 .40], 'color', 'w');
plot(SigDataCont, 'color', [0 0.1 0.5]);
ybounds = ylim;

title('Raw Vibration Signal Data Collected until Failure (A02)','fontsize', font_size, 'FontWeight','bold');
ylabel('Vibration Signal Amplitude'); 
xlabel('Data #');

figure('name', ' Compressed Data after Time Synchrounous Averaging (A02)', ... 
                'units','normalized','position', [.03 .05  .93 .35], 'color', 'w');
plot(TSA_A02_Data, 'color', [0 0.5 1] );
title('Compressed Data after Time Synchrounous Averaging (A02)', 'fontsize', font_size,'FontWeight','bold');
ylabel('Vibration Signal Amplitude'); 
xlabel('Data #');

% figure('name', ' Raw Vibration Signal Data Collected until Failure (A02)', ... 
%                 'units','normalized','position', [.03 .50  .93 .40]);
% plot(SigDataCont, 'color', [1 0.1 0.5]);
% ybounds = ylim;
% hold on;
% line([1.5e7,1.5e7],[ybounds(1),ybounds(2)], 'Color',[.01 .2 .01]);
