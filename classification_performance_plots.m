
clear all
close all
clc

p = 10; % number of dimensions
N = 1000; % number of datapoints
type = 'T1';
clusterDistribution = 0.5;
maxSampleSize = 50;%round(20*log(p));

distance = 1.3; % manual konstant

Generate_classData;

H = X*inv(X'*X)*X'; 

pi = diag(H)./sum(diag(H));


% H-dist
figure
bar(abs(sort(pi.*t)));

figure

[~, idxSort] = sort(pi.*t);
piLog = log(pi).*t;
bar(piLog(idxSort));

figure
[~, idxSort] = sort(pi.*t);
maxPi = abs(min(log(pi)));
piLog = (maxPi-abs(log(pi)));
bar(piLog(idxSort));



%% Calculate parameters and find log(squared error)

stepSize = 1;
R = (p+1):stepSize:(p+maxSampleSize);
Ew = [];
Eu = [];
%hold on
for i = 1:length(R)
    parfor rep=1:35
        r = R(i);
        [P] = SubsampleLogReg( X,t,pi,r);
        Ew(rep,i) = class_error( P,t );
        [PU] = SubsampleLogReg( X,t,ones(1,N)./N,r);
        Eu(rep,i)  = class_error( PU,t );
    end
end

%% %
% Learning curves, based on mean and .25 and .75 quantile
%%%
figure
lev = quantile((Ew),[0.25 0.5 .75]);
uni = quantile((Eu),[0.25 0.5 .75]);
xAxis = (1:length(R)) + p; %Num of samples
hold on
%Plotting the mean
plot(xAxis, lev(2,:), 'b', 'LineWidth', 3)
plot(xAxis, uni(2,:), 'r', 'LineWidth', 3)
% Plotting the 0.25 and 0.75 quantile
plot(xAxis, lev(1, :) ,'--b', xAxis, lev(3,:),'--b')
plot(xAxis, uni(1, :) ,'--r', xAxis, uni(3,:),'--r')

%title(sprintf('Classification for %s distribution \n N = %i , p = %i',type,N,p), 'fontweight','bold','fontsize',16)
title(sprintf('%s',type), 'fontweight','bold','fontsize',64)
hleg = legend('Mean Lev', 'Mean Uni', 'q25 Lev', 'q75 Lev', 'q25 Uni', 'q75 Uni')
set(hleg,'fontsize',20)
set(gca, 'xcolor', [0 0 0],'ycolor', [0 0 0],'color', 'none');
set(gcf, 'color', 'none','inverthardcopy', 'off');

ylabel('#Miss-classifications','fontsize', 18)
xlabel('#Samples','fontsize', 18)

xlim([xAxis(1) xAxis(end)])

hold off
