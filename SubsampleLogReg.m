function [ Plin, Pglm, idx ] = SubsampleLogReg( X,t,pi,r)
%SubsampleLogReg makes a logistic model, based on r-samples, selected 
% acording to the probability distribution pi, and tests the model on
% the whole dataset.
% 
% X  : the data
% t  : the targets
% pi : is the probability distribution
% showPlots : Whether to draw plots or not 
%
n = numel(t);
N = size(X,1);

%% sampling from pi
picum = cumsum(pi);
samp = rand(1,r);
idx = zeros(r,1);
for i=1:r
    idx(i) = find(picum>=samp(i),1,'first');
end

%% Generating D

D = diag(1./sqrt(r*pi(idx)));
%Du = diag(ones(1,r)*sqrt(n/r));
Sx = zeros(n,r);
for i = 1:length(idx);
   Sx(idx(i),i) = 1;
end



%% Solving the weighted LS
ySamp = D*Sx'*t;
xSamp = D*Sx'*X;

B = xSamp\ySamp; %Same, but faster

%% Finding the log of the squared error
%sqErr = log(norm(t-X*B,2)); %Euclidian
%E = sum((y-X*B).^2);


% exercise 5.2.6
%% Fit logistic regression model and evaluate
ySamp0 = t(idx);
ySamp0(ySamp < 0) = 0;
w_est = glmfit(xSamp, ySamp0, 'binomial');
%%%test on entire data!!!!!
%t0 = t; t0(t<0) = 0;
%w_est = glmfit(X, t0, 'binomial');
%%%

% Evaluate the logistic regression for the new data object
Pglm = glmval(w_est, X, 'logit');

Plin = 1./(1+exp(-X*B));

end