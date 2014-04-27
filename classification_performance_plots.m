
clear all
close all
clc

p = 10; % number of dimensions
N = 1000; % number of datapoints
r = 20; % sample size
type = 'GA';
clusterDistribution = 0.5;

distance = 1.3; % manual konstant

Generate_classData;

H = X*inv(X'*X)*X'; 

pi = diag(H)./sum(diag(H));


% H-dist
figure
bar(abs(sort(pi.*t)));



%% Calculate parameters and find log(squared error)
maxSampleSize = round(20*log(p));
stepSize = 1;
R = (p+1):stepSize:(p+maxSampleSize);
Ew = [];
Eu = [];
%hold on
for i = 1:length(R)
    parfor rep=1:30
        r = R(i);
        [~,P] = SubsampleLogReg( X,t,pi,r);
        Ew(rep,i) = class_error( P,t );
        [~,PU] = SubsampleLogReg( X,t,ones(1,N)./N,r);
        Eu(rep,i)  = class_error( PU,t );
    end
end
%%

boxplot(Eu,'colors','r','plotstyle','compact')
hold on
boxplot(Ew,'colors','b','plotstyle','compact')

ylabel 'Error'
xlabel '# of samps over d '
%legend( 'H', 'U')
title(sprintf('N = %i, d = %i \nLeveraging sampling blue \nUniform sampling red',N,p))
%title 'error'
%axis auto
hold off

