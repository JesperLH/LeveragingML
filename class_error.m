function [ E ] = class_error( p,t )
%CLASS_ERROR Evaluate the classification error
% p = probability prediction
% t = true targets
% E = number of wrong classifications



p(p < 0.5) = -1;
p(p > 0.5) = 1;
E = numel(t) - sum(p == t);

%% maybe exponential error later

end

