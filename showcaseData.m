
close all
titleSize = 32
% Ga
N = 1000;
p = 2;
yaxis = [-10 10];
xaxis = [-50 50];
type = 'GA';
[X,y] = generateData(N,p,type);
X = (X-repmat(mean(X),N,1))./repmat(sqrt(var(X)),N,1);
subplot(1,3,1)
%hist(X,50)
plot(X(:,1),X(:,2),'ob');
title('GA','fontweight','bold','fontsize',titleSize);
ylim(yaxis)
xlim(xaxis)
set(gca, 'xcolor', [0 0 0],'ycolor', [0 0 0],'color', 'none');

% T3
type = 'T3';
[X,y] = generateData(N,p,type);
X = (X-repmat(mean(X),N,1))./repmat(sqrt(var(X)),N,1);
subplot(1,3,2)
%hist(X,50)
plot(X(:,1),X(:,2),'ob');
title('T3','fontweight','bold','fontsize',titleSize);
ylim(yaxis)
xlim(xaxis)
set(gca, 'xcolor', [0 0 0],'ycolor', [0 0 0],'color', 'none');

% T1

type = 'T1';
[X,y] = generateData(N,p,type);
X = (X-repmat(mean(X),N,1))./repmat(sqrt(var(X)),N,1);
subplot(1,3,3)
%hist(X,50)
plot(X(:,1),X(:,2),'ob');
title('T1','fontweight','bold','fontsize',titleSize);
xlim(xaxis)
ylim(yaxis) 
set(gca, 'xcolor', [0 0 0],'ycolor', [0 0 0],'color', 'none');
set(gcf, 'color', 'none','inverthardcopy', 'off');
