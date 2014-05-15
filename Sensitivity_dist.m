function [ pi ] = Sensitivity_dist( X,t,r )
%SENSITIVITY_DIST Summary of this function goes here
%   Detailed explanation goes here

N = size(X,1);
p = size(X,2);

%% "Sensitivity" regression

r_init = max(round(r/10),1);

% sampling small initial uniformly
[~, idx1] = WRS(X(t==1),ones(N/2,1),r_init);
[~, idx2] = WRS(X(t==-1),ones(N/2,1),r_init);

idx_init = [idx1; idx2+round(N/2)];

% fitting the initial model
% 
% svmStr = svmtrain(X(idx_init,:),t(idx_init));
% 
% w = (svmStr.Alpha' * full(svmStr.SupportVectors));
% w = [svmStr.Bias w];

w0 = glmfit(X(idx_init,:), t(idx_init)==1, 'binomial')';

X = [ones(N,1) X];


%m = mean(X(idx_init,:),1) %mean point
%plot(m(1),m(2),'ok') % see where the mean point is
%[1 m] * w' % gives a score close to zero because its close to the line


%% calculating the score


ewx = exp(X*w0');
newx = exp(-X*w0');

yh = 1./(1+newx);

yhdw = X.*repmat(newx./(newx+1).^2,[1,p+1]);

yhdw(isnan(yhdw)) = 0;

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

% yhdy = yhdw * Ldwdw^(-1) * Ldydw
yhdy = yhdw * (Ldwdw\Ldydw);

pi = yhdy./sum(yhdy);

if isnan(pi)
       pi 
end

end

