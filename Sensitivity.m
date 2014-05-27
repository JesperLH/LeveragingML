function [ P , w_est] = Sensitivity( X,t,r )
%SENSITIVITY_DIST Summary of this function goes here
%   Detailed explanation goes here

N = size(X,1);
p = size(X,2);

%% "Sensitivity" regression

r_init = max(round(r/6)*2,4);

% sampling small initial uniformly
[~, idx1] = WRS(X(t==1),ones(N/2,1),round(r_init/2));
[~, idx2] = WRS(X(t==-1),ones(N/2,1),r_init-round(r_init/2));

idx_init = [idx1; idx2+round(N/2)];

% fitting the initial model
% 
%svmStr = svmtrain(X(idx_init,:),t(idx_init));
% 
% w0 = (svmStr.Alpha' * full(svmStr.SupportVectors));
% w0 = [svmStr.Bias w0];

w0 = glmfit(X(idx_init,:), t(idx_init)==1, 'binomial')';

X = [ones(N,1) X];

% 
% m = mean(X(idx_init,:),1) %mean point
% plot(m(1),m(2),'ok') % see where the mean point is
% m % gives a score close to zero because its close to the line


%% calculating the score

yhdw = X.*repmat(exp(-X*w0')./(exp(-X*w0')+1).^2,[1,p+1]);

yhdw(isnan(yhdw)) = eps;

Ldwdw = zeros(p+1);

for n = 1:N
    Xn = X(n,:);
    
    if t(n)==1
        C = - Xn'*Xn*exp(-Xn*w0')/(1+exp(-Xn*w0')); 
    else
        C = - Xn'*Xn/(1+exp(-Xn*w0'));
    end
    
    if isfinite(C)
        Ldwdw = Ldwdw + C;
    end
    
    if ~isfinite(Ldwdw)
       Ldwdw 
    end
    
end

Ldydw = sum(X,1)';

% old yhdy = yhdw * Ldwdw^(-1) * Ldydw
yhdy = yhdw * (Ldwdw\Ldydw);

pi = yhdy;

pi = abs(pi);

pi = pi./sum(pi);

%% Soft-max on the weights
pi = exp(yhdy)/sum(exp(yhdy));
figure
plot(sort(pi))
%%


if(any(isnan(pi)))
    disp('NAN!!!!')
end


%% sampling from pi

ip = setdiff(find(t==1),idx_init);
in = setdiff(find(t==-1),idx_init);

r = r - numel(idx_init);

[~, idx1] = WRS(X(ip),pi(ip),round(r/2));
[~, idx2] = WRS(X(in),pi(in),r-round(r/2));

idx = union([idx1; idx_init],idx2+round(size(X,1)/2));

xSamp = X(idx,:);
ySampBin = t(idx)==1;

% exercise 5.2.6 ?
%% Fit logistic regression model and evaluate

%w_est = glmfit(xSamp, ySampBin, 'binomial','weights',1./sqrt(r*pi(idx)));
w_est = glmfit(xSamp, ySampBin, 'binomial');

% Evaluate the logistic regression for the new data object
P = glmval(w_est, X, 'logit');


end

