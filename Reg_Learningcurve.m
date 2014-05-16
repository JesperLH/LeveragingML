%% Generate probability distribution
clear all
close all
clc
N = 1000;
p = 10; %Dimensions, must be >= 20
R = [(p+1):(p+50)]; %Sample sizes to try

type = 'T1';
[X,y] = generateData(N,p,type);

H = X*inv(X'*X)*X';
pi = diag(H)./p;

bar(sort(pi))
%% Calculate parameters and find log(squared error)
%R = [(p+1):(p+10) (p+20):50:(N/2)];
Ew = [];
Eu = [];
%hold on
for i = 1:length(R)
    parfor rep=1:30
        r = R(i);
        [Bw ,Ew(rep,i)] = SubsampleLS( X,y,pi,r );
        [Bu ,Eu(rep,i)] = SubsampleLS( X,y, ones(N,1)/N, r );
    end
end
%%
boxplot(Eu,'colors','r','plotstyle','compact')
hold on
boxplot(Ew,'colors','b','plotstyle','compact')
ylabel 'Log Error'
xlabel '# of samps over d '
%legend( 'H', 'U')
title(sprintf('N = %i, d = %i \nLeveraging sampling blue \nUniform sampling red',N,p))
%title 'error'
%axis auto
hold off

%% %
% Learning curves, based on mean and .25 and .75 quantile
%%%
figure
lev = quantile((Ew),[0.25 0.5 .75])
uni = quantile((Eu),[0.25 0.5 .75])
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
set(hleg,'fontsize',16)

ylabel('#Miss-classifications','fontsize', 16)
xlabel('#Samples','fontsize', 16)
xlim([xAxis(1) xAxis(end)])

hold off