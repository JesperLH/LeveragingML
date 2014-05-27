function [ Pglm, idx ] = SubsampleLogReg( X,t,pi,r)
%SubsampleLogReg makes a logistic model, based on r-samples, selected 
% acording to the probability distribution pi, and tests the model on
% the whole dataset.
% 
% X  : the data
% t  : the targets
% pi : is the probability distribution
% showPlots : Whether to draw plots or not 
%
N = size(X,1);

%% sampling from pi

[~, idx1] = WRS(X(t==1),pi(t==1),round(r/2));
[~, idx2] = WRS(X(t==-1),pi(t==-1),r-round(r/2));

idx = [idx1; idx2+round(size(X,1)/2)];

xSamp = X(idx,:);
ySampBin = t(idx)==1;

% exercise 5.2.6 ?
%% Fit logistic regression model and evaluate

w_est = glmfit(xSamp, ySampBin, 'binomial','weights',1./sqrt(r*pi(idx)));
%w_est = glmfit(xSamp, ySampBin, 'binomial');

% Evaluate the logistic regression for the new data object
Pglm = glmval(w_est, X, 'logit');

end