function [AR_pred, arpoly] = ARmod( RMS_meansub, lag, test_len)


ARy_ = aryule(RMS_meansub(1:test_len), lag);
ARy_ = ARy_*(-1);
ARy = ARy_(2:length(ARy_));

arpoly = ar(RMS_meansub(1:test_len), lag);

for i = 1:length(RMS_meansub)-lag %AR lag:136

    AR_pred(i) = ARy*RMS_meansub(i:i+lag-1); 

end

eps =  RMS_meansub(lag+1:end) - transpose(AR_pred);
tr_len = 2:40; % for 39 residuals
%tr_eps = RMS_meansub(tr_len) -  AR_modelRMS40.a(2)*(-1)*RMS_meansub(tr_len);

RMS_title = sprintf('Actual Performance of Root Mean Square per Target Gear Sample w/ Subtracted Mean, Lag Order: %d', lag);
ARvsPerf_title = sprintf('AR Model Prediction vs. Actual Performance, Lag order: %d', lag);
resid_title = sprintf( 'Control Chart Residuals, Lag Order: %d', lag);

% Plot RMS only
figure('name', RMS_title, ... 
                'units','normalized','position', [.05 .47  .43 .43], 'color', 'w')
plot(RMS_meansub, 'LineWidth',2, 'color' , 'b');
ylim([-100, 900]);
title(RMS_title);
ylabel('Root Mean Square subtracted mean'); 
xlabel('File number 41:136');

hold on;
xbounds = [test_len, test_len];
ylimit = ylim;
hold on;
line([xbounds(1), xbounds(2)],[ylimit(1), ylimit(2)], 'LineStyle', '--', 'Color', 'R', 'LineWidth',2);


% AR Model Prediction vs. Actual Performance
figure('name', ARvsPerf_title, ... 
                'units','normalized','position', [.05 .47  .43 .43], 'color', 'w')
RMS_meansubplot = plot(RMS_meansub, 'LineWidth',2, 'color' , 'b');
title(ARvsPerf_title);
ylabel('Root Mean Square subtracted mean'); 
xlabel('File number 41:136');
hold on;
AR_predplot = plot( lag+1:136, AR_pred,'LineWidth', 2, 'color' , [0 0.6 0]);
legend([RMS_meansubplot,AR_predplot],'RMS w/ subtracted mean','AR Model', ...
                'Location','NorthWest');

% Control Chart Residuals
figure('name', resid_title, 'units',...
                'normalized','position',[.5 .47 .43 .43], 'color', 'w')
resid_plot = plot(lag+1:length(RMS_meansub),eps, '--gs', 'LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize', 3);
title(resid_title);
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





end