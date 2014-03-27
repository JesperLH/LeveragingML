clear all
close all
clc
N = 10000;
p = 100; %Dimensions, must be >= 20
r = 0; %Initialise
noise = 0.5;


% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', 15)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Times New Roman')
set(0,'DefaultTextFontSize', 15)



[X,y] = generateData(N,p,'GA');
H = X*inv(X'*X)*X';
pi = diag(H)./p;
bar(sort(pi))
axis tight
title('GA sorted \pi-distribution')
xlabel 'Datapoints'
ylabel 'PDF value'

figure
[X,y] = generateData(N,p,'T1');
H = X*inv(X'*X)*X';
pi = diag(H)./p;
bar(sort(pi))
axis tight
title('T1 sorted \pi-distribution')
xlabel 'Datapoints'
ylabel 'PDF value'

figure
[X,y] = generateData(N,p,'T3');

H = X*inv(X'*X)*X';
pi = diag(H)./p;
bar(sort(pi))
axis tight
title('T3 sorted \pi-distribution')
xlabel 'Datapoints'
ylabel 'PDF value'
