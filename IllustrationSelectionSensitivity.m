clear all
close all
clc

p = 2; % number of dimensions
N = 200; % number of datapoints
r = 16; % sample size
type = 'T3';
clusterDistribution = 0.5;

distance = 1.3; % manual konstant

Generate_classData;

%% "Logistic" regression

[  ~, ~ , idx] = Sensitivity(X,t,r );

[~, idx1] = WRS(X(t==1),ones(N/2,1),round(r/2));
[~, idx2] = WRS(X(t==-1),ones(N/2,1),r-round(r/2));
idxUniform = [idx1; idx2+round(size(X,1)/2)];



%% Ilustrates the example if two-dimensional
%Find axis
xmin = min(X(:,1))-3;
xmax = max(X(:,1))+3;
ymin = min(X(:,2))-3;
ymax = max(X(:,2))+3;

%% Plot
figure
%First plot the sampled data
hold on
plot(X(t == 1,1),X(t == 1,2),'.b','markerSize',16);
plot(X(t == -1,1),X(t == -1,2),'.r','markerSize',16);

plot(X(idx,1),X(idx,2),'om','markerSize',14,'Linewidth', 2.5);
plot(X(idxUniform,1),X(idxUniform,2),'xk','markerSize',14,'Linewidth', 2.5);

axis([xmin xmax ymin ymax])
hold off
title(sprintf('%s',type), 'fontweight','bold','fontsize',64)
hleg = legend('Class 1','Class 2','Sen-sample','Uni-sample','Data','Location','BestOutside');
set(hleg,'fontsize',20)
set(gca, 'xcolor', [0 0 0],'ycolor', [0 0 0],'color', 'none');
set(gcf, 'color', 'none','inverthardcopy', 'off');

ylabel('2-dimension','fontsize', 18)
xlabel('1-dimension','fontsize', 18)
