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

%   Start making the AR prediction model from RMS file 41 - 136
%testing_len = 1:135;
%RMS_len = length(RMS_meansub(testing_len));

%AR_modelRMS40 = importdata('AR_modelRMS40_.mat');

lag = 15;

ARy_ = aryule(RMS_meansub(1:40), lag);
ARy_ = ARy_*(-1);
ARy = ARy_(2:length(ARy_));

for i = 1:length(RMS_meansub)-lag %AR lag:136

    AR_pred(i) = ARy*RMS_meansub(i:i+lag-1); 

end

eps =  RMS_meansub(lag+1:end) - transpose(AR_pred);
tr_len = 2:40; % for 39 residuals
%tr_eps = RMS_meansub(tr_len) -  AR_modelRMS40.a(2)*(-1)*RMS_meansub(tr_len);


% Plot RMS only
figure('name', ' Actual Performance of Root Mean Square per Target Gear Sample w/ Subtracted Mean', ... 
                'units','normalized','position', [.05 .47  .43 .43], 'color', 'w')
plot(RMS_meansub, 'LineWidth',2, 'color' , 'b');
ylim([-100, 900]);
title('AR Model Prediction vs. Actual Performance of mean subtracted RMS values');
ylabel('Root Mean Square subtracted mean'); 
xlabel('File number 41:136');

hold on;
xbounds = [40, 40];
ylimit = ylim;
hold on;
line([xbounds(1), xbounds(2)],[ylimit(1), ylimit(2)], 'LineStyle', '--', 'Color', 'R', 'LineWidth',2);


% AR Model Prediction vs. Actual Performance
figure('name', ' AR Model Prediction vs. Actual Performance', ... 
                'units','normalized','position', [.05 .47  .43 .43], 'color', 'w')
RMS_meansubplot = plot(RMS_meansub, 'LineWidth',2, 'color' , 'b');
title('AR Model Prediction vs. Actual Performance of mean subtracted RMS values');
ylabel('Root Mean Square subtracted mean'); 
xlabel('File number 41:136');
hold on;
AR_predplot = plot( lag+1:136, AR_pred,'LineWidth', 2, 'color' , [0 0.6 0]);
legend([RMS_meansubplot,AR_predplot],'RMS w/ subtracted mean','AR Model', ...
                'Location','NorthWest');

% Control Chart Residuals
figure('name', 'Control Chart Residuals', 'units',...
                'normalized','position',[.5 .47 .43 .43], 'color', 'w')
resid_plot = plot(lag+1:length(RMS_meansub),eps, '--gs', 'LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize', 3);
title('Residual values for AR model');
ylabel('Root Mean Square subtracted mean'); 
xlabel('File number 41:136');

% hold on;
% plot(76, eps(76-1), 'rs','MarkerEdgeColor','k',...
%                 'MarkerFaceColor','b',...
%                 'MarkerSize', 5);
hold on;
xbounds = xlim;
ylim([-100, 850]);
ystdlimit = (3)*std(eps(lag+1:test_len));
AR_cb = line([xbounds(1), xbounds(2)],[ystdlimit, ystdlimit], 'Color', 'R', 'LineWidth',2);
hold on;
line([xbounds(1), xbounds(2)],[-ystdlimit, -ystdlimit], 'Color', 'R', 'LineWidth',2);
legend([AR_cb , resid_plot],'AR Model 3 Sigma Control Bounds','Residuals', ...
                'Location','NorthWest');

