%% Generate probability distribution
clear all
close all
clc
N = 1000;
p = 10; %Dimensions, must be >= 20
r = 0; %Initialise
noise = 0.5;

%[X,y] = generateData(N,p,'GA');
%[X,y] = generateData(N,p,'T1');
[X,y] = generateData(N,p,'T3');

H = X*inv(X'*X)*X';
pi = diag(H)./p;

bar(sort(pi))
%% Calculate parameters and find log(squared error)
maxSampleSize = 2*p;
stepSize = 2;
R = (p+1):stepSize:(p+maxSampleSize);
Ew = [];
Eu = [];
%hold on
for i = 1:length(R)
    parfor rep=1:30
        r = R(i);
        [Bw ,Ew(rep,i)]  = SubsampleLS( X,y,pi,r );
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
title(sprintf('N = %i, d = %i, noise = %1.2f \nLeveraging sampling blue \nUniform sampling red',N,p,noise))
%title 'error'
axis auto
hold off