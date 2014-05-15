

%% Covariance matrix

sigma = zeros(p,p);
for i = 1:p
    for j = 1:p
        sigma(i,j) = 2*0.5^abs(i-j);
    end
end

%% Difference between clusters

D = randn(1,p);
D = D./norm(D);

D = D*sigma*distance;


switch type
    case 'GA'
        X = mvnrnd(zeros(p,1),sigma,N);
    case 'T1'
        X = mvtrnd(sigma,1,N); %T dist Data with zero mean
    case 'T3'
        X = mvtrnd(sigma,3,N); %T dist Data with zero mean
end

N1 = round(N*clusterDistribution);
N2 = N-N1;

D = [repmat(-D,N1,1);repmat(D,N2,1)];

X = X+D;

t = [-ones(N1,1); ones(N2,1)];


if false%(size(X,2) == 2)
    figure
    plot(X(1:N1,1),X(1:N1,2),'.b',X(N2+1:N,1),X(N2+1:N,2),'.r')
    legend('Class 1', 'Class 2');
    title(sprintf('Simulated data\n %s distribution',type));
end

%% Random permutation for more realism

%R = randperm(N);

%X = X(R,1:size(X,2));
%t = t(R);
