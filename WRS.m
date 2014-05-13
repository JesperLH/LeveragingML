function [sample, index] = WRS(X,w,r)
% Returns a weighted random sample without replacement
% Based on [2005; Efraimidis, Spirakis]
%http://utopia.duth.gr/~pefraimi/research/data/2007EncOfAlg.pdf
%
% X is the data to be sampled
% w is the weights
% r is the number of samples
if (size(w,2) > 1)
    w = w';
end

if sum(w)~=1
    w = w./sum(w);
end
    
    

u = rand(size(X,1),1);
k = u.^(1./w);

[~,index] = sort(k,'descend');
sample = X(index(1:r),:);
index = index(1:r);
end