function [ w_est, Err , w_estH , ErrH ] = SubsampleLogReg( X,t,pi,r , showPlots)
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
if (size(X,2) ~= 2) showPlots = false; end
%% sampling from pi
pi = cumsum(pi);
samp = rand(1,r);
idx = zeros(r,1);
for i=1:r
    idx(i) = find(pi>=samp(i),1,'first');
end

%% Generating D

D = diag(1./sqrt(r*pi(idx)));
%Du = diag(ones(1,r)*sqrt(n/r));
Sx = zeros(n,r);
for i = 1:length(idx);
   Sx(idx(i),i) = 1;
end

%% Ilustrates the example if two-dimensional
if size(X,2) == 2 && showPlots
    illustrate2D2Class(X,t,idx);
end

%% Solving the weighted LS
ySamp = D*Sx'*t;
xSamp = D*Sx'*X;

B = xSamp\ySamp; %Same, but faster

%% Finding the log of the squared error
sqErr = log(norm(t-X*B,2)); %Euclidian
%E = sum((y-X*B).^2);


% exercise 5.2.6
%% Fit logistic regression model and evaluate
ySamp0 = t(idx);
ySamp0(ySamp < 0) = 0;
w_est = glmfit(xSamp, ySamp0, 'binomial');

% Evaluate the logistic regression for the new data object
P = glmval(w_est, X, 'logit');

temp = X*B;
temp(temp>0) = 2;
temp(temp<0) = -1;

if showPlots
    figure
    plot(1:N,P,'.b',1:N,temp,'.r');
    title('Logistic regression in Matlab vs. Homebrew');
    xlabel('Observations sorted acoording to probability of beloing to class 1')
    ylabel('Estimated target value, class 1 is > 0, class 2 < 0')
    legend('Log-reg Matlab','Homebrew');
end

%%
%Return values
w_estH = B;
%w_est already set
P = round(P);
P(P < 1) = -1;
Err = 1-sum(P == t)/size(X,1);

temp(temp>0) = 1;
ErrH = 1-sum(temp == t)/size(X,1);

end