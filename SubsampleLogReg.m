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
N = size(X,1);

%% sampling from pi

[~, idx1] = WRS(X(t==1),pi(t==1),round(r/2));
[~, idx2] = WRS(X(t==-1),pi(t==-1),r-round(r/2));

idx = [idx1; idx2+round(size(X,1)/2)];



% picum = cumsum(pi);
% samp = rand(1,r);
% idx = zeros(r,1);
% for i=1:r
%     idx(i) = find(picum>=samp(i),1,'first');
% end

%% Generating D

D = diag(1./sqrt(r*pi(idx)));
%Du = diag(ones(1,r)*sqrt(n/r));
Sx = zeros(N,r);
for i = 1:length(idx);
   Sx(idx(i),i) = 1;
end

ySamp = D*Sx'*t;
xSamp = D*Sx'*X;


% exercise 5.2.6 ?
%% Fit logistic regression model and evaluate
if nargout>1
 ySampBin = t(idx);
 ySampBin(ySampBin < 0) = 0;
w_est = glmfit(xSamp, ySampBin, 'binomial');
%%%test on entire data!!!!!
%t0 = t; t0(t<0) = 0;
%w_est = glmfit(X, t0, 'binomial');
%%%


% Evaluate the logistic regression for the new data object
Pglm = glmval(w_est, X, 'logit');
end


%% Solving the weighted LS


B = [ones(r,1) xSamp]\ySamp; %Same, but faster



Plin = 1./(1+exp(-[ones(N,1) X]*B));

end