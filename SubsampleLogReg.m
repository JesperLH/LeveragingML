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

%% Generating D
%  
% D = diag(1./sqrt(r*pi(idx)));
% %Du = diag(ones(1,r)*sqrt(n/r));
% Sx = zeros(N,r);
% for i = 1:length(idx);
%    Sx(idx(i),i) = 1;
% end
% 
% ySamp = D*Sx'*t;
% xSamp = D*Sx'*X;
%  

% Ved at udkommentere dette f�r vi performance som Uniform altid.
% m�ske skalerer det vigtigheden pi for regression medn ikke for klass ?
% hvad er forskellen egentlig mellem regression og klassifikation ?
% Sigmoidfunction ?
% Den er ikke en gang viktig for regression.
ySamp = t(idx);
xSamp = X(idx,:);

% exercise 5.2.6 ?
%% Fit logistic regression model and evaluate
 
    ySampBin = t(idx);
    ySampBin(ySampBin == -1) = 0;
    w_est = glmfit(xSamp, ySampBin, 'binomial','weights',1./sqrt(r*pi(idx)));

    % Evaluate the logistic regression for the new data object
    Pglm = glmval(w_est, X, 'logit');

end