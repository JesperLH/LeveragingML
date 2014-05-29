clear all
clc
close all
titleSize = 32;
% Ga
yaxis = [-4 4];
xaxis = [-4 4];
p = 2; % number of dimensions
N = 500; % number of datapoints

clusterDistribution = 0.5;
maxSampleSize = 50;%round(20*log(p));
distance = 1.3; % manual konstant


%%

type = 'GA';
Generate_classData;
X = (X-repmat(mean(X),N,1))./repmat(sqrt(var(X)),N,1);
subplot(1,3,1)
%hist(X,50)
hold on
plot(X(t == -1,1),X(t == -1,2),'ob','markerSize',12);
plot(X(t == 1,1),X(t == 1,2),'or','markerSize',12);
hold off

title('GA','fontweight','bold','fontsize',titleSize);
ylim(yaxis)
xlim(xaxis)
set(gca, 'xcolor', [0 0 0],'ycolor', [0 0 0],'color', 'none');

%%
% T3
type = 'T3';
Generate_classData;
X = (X-repmat(mean(X),N,1))./repmat(sqrt(var(X)),N,1);
subplot(1,3,2)
%hist(X,50)
hold on
plot(X(t == -1,1),X(t == -1,2),'ob','markerSize',12);
plot(X(t == 1,1),X(t == 1,2),'or','markerSize',12);
hold off

title('T3','fontweight','bold','fontsize',titleSize);
ylim(yaxis)
xlim(xaxis)
set(gca, 'xcolor', [0 0 0],'ycolor', [0 0 0],'color', 'none');

% T1

type = 'T1';
Generate_classData;
X = (X-repmat(mean(X),N,1))./repmat(sqrt(var(X)),N,1);
subplot(1,3,3)
%hist(X,50)
hold on
plot(X(t == -1,1),X(t == -1,2),'ob','markerSize',12);
plot(X(t == 1,1),X(t == 1,2),'or','markerSize',12);
hold off

title('T1','fontweight','bold','fontsize',titleSize);
xlim(xaxis)
ylim(yaxis) 
set(gca, 'xcolor', [0 0 0],'ycolor', [0 0 0],'color', 'none');
set(gcf, 'color', 'none','inverthardcopy', 'off');
