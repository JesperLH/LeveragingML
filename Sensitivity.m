
clear all
close all
clc

p = 2; % number of dimensions
N = 100; % number of datapoints
r = 20; % sample size
type = 'T3';
clusterDistribution = 0.5;

distance = 1.3; % manual konstant
Generate_classData;

%% "Sensitivity" regression

r_init = max(round(r/10),1);

% sampling small initial uniformly
[~, idx1] = WRS(X(t==1),2/N,r_init);
[~, idx2] = WRS(X(t==-1),2/N,r_init);

idx_init = [idx1; idx2+round(N/2)];

% fitting the initial model

svmStr = svmtrain(X(idx_init,:),t(idx_init),'showplot',true);
hold on

w = (svmStr.Alpha' * full(svmStr.SupportVectors));
w = [svmStr.Bias w];

X = [ones(N,1) X];
%m = mean(X(idx_init,:),1) %mean point
%plot(m(1),m(2),'ok') % see where the mean point is
%[1 m] * w' % gives a score close to zero because its close to the line


%% calculating the score


ewx = exp(X*w');
newx = exp(-X*w');

yh = 1./(1+newx);

yhdw = X.*repmat(newx./(newx+1).^2,[1,p+1]);

Ldwdw = zeros(p+1);

for n = 1:N
    Xn = X(n,:);

    if t(n)==1
        Ldwdw = Ldwdw - Xn'*Xn*exp(-Xn*w')/(1+exp(-Xn*w')); 
    else
        Ldwdw = Ldwdw - Xn'*Xn/(1+exp(-Xn*w'));
    end
end

Ldydw = sum(X,1)';

% yhdy = yhdw * Ldwdw^(-1) * Ldydw
yhdy = yhdw * (Ldwdw\Ldydw);

%%

pi = yhdy./sum(yhdy);

figure
bar(sort(pi.*t))
xlabel('Observations')
ylabel('log( h_{i i} ) multiplied by t_i ')
axis tight

%% Sampling
[Plin, Pglm, idx] = SubsampleLogReg( X(:,2:end),t,pi,r);

%uniform sampling
[~ , ~, idxUniform] = SubsampleLogReg( X(:,2:end),t,ones(N,1)/N,r);

%% Ilustrates the example if two-dimensional

X = X(:,2:end);

if size(X,2) == 2 
    
    
xmin = min(X(:,1))-3;
xmax = max(X(:,1))+3;
ymin = min(X(:,2))-3;
ymax = max(X(:,2))+3;

xSamp = X(idx,1:2);

    
    
hold on
plot(X(t == -1,1),X(t == -1,2),'.b','markerSize',12);
plot(X(t == 1,1),X(t == 1,2),'.r','markerSize',12);
axis([xmin xmax ymin ymax])

%In the same plot, plot circles around the sample points.
%Different colors are used, so to better distingues in large datasets.
plot(xSamp(t(idx) == -1,1),xSamp(t(idx) == -1,2),'om','markerSize',16,'Linewidth', 2);
plot(xSamp(t(idx) == 1,1),xSamp(t(idx) == 1,2),'ok','markerSize',16,'Linewidth', 2);
hold off
legend('Class 1','Class 2', 'S-class 1', 'S-class 2');
title('Entire dataset, with sampled points circled');
xlabel('x'); ylabel('y');
end
