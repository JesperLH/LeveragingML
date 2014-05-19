function [ B, sqErr, idx ] = SubsampleLS( X,y,pi,r )
% pi is the probability distribution
%SUBSAMPLELS

n = numel(y);

%% sampling from pi
%pi = cumsum(pi);
%samp = rand(1,r);
%idx = zeros(r,1);
%for i=1:r
%    idx(i) = find(pi>=samp(i),1,'first');
%end
[~, idx] = WRS(X,pi,r);
%idx = randsample(length(pi),r,true,pi);

%% Generating D

D = diag(1./sqrt(r*pi(idx)));
%Du = diag(ones(1,r)*sqrt(n/r));
Sx = zeros(n,r);
for i = 1:length(idx);
   Sx(idx(i),i) = 1;
end


%% Solving the weighted LS
ySamp = D*Sx'*y;
xSamp = D*Sx'*X;

%ySamp = y(idx);
%xSamp = X(idx,:);

%B = (xSamp'*xSamp)^(-1)*xSamp'*ySamp;
B = xSamp\ySamp; %Same, but faster

W = Sx*D^2*Sx';
% What is this for ?
%B1 = inv(X'*W*X)*X'*W*y;


%% Finding the log of the squared error
sqErr = log(norm(y-X*B,2)); %Euclidian
%E = sum((y-X*B).^2);


%Xs = D*X(idx,:);

%B= (Xs'*Xs)\Xs'*D*y(idx);

%B = pinv(Xs)*D*y(idx);





end

