


% Ga
N = 50000;
p = 1;
type = 'GA';
[X,y] = generateData(N,p,type);
subplot(1,3,1)
hist(X,50)
title('GA','fontweight','bold','fontsize',16);
ylim([0 5*10^4])


% T3
type = 'T3';
[X,y] = generateData(N,p,type);
subplot(1,3,2)
hist(X,50)
title('T3','fontweight','bold','fontsize',16);
ylim([0 5*10^4])


% T1

type = 'T1';
[X,y] = generateData(N,p,type);
subplot(1,3,3)
hist(X,50)
title('T1','fontweight','bold','fontsize',16);

ylim([0 5*10^4])

