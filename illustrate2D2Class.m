function [] = illustrate2D2Class(X,t,idx)
% Illustration of which samples are chosen for 2D 2-class
% Classification problem

%Find axis
xmin = min(X(:,1))-3;
xmax = max(X(:,1))+3;
ymin = min(X(:,2))-3;
ymax = max(X(:,2))+3;

%% Plot
figure
%First plot the sampled data
subplot 211
hold on
xSamp = X(idx,1:2);
plot(xSamp(t(idx) == -1,1),xSamp(t(idx) == -1,2),'.b');
plot(xSamp(t(idx) == 1,1),xSamp(t(idx) == 1,2),'.r');
axis([xmin xmax ymin ymax])
legend('Class 1','Class 2');
title('Sample data points');
xlabel('x'); ylabel('y');
hold off

%Then plot all the data in another plot.
%subplot 212
figure
hold on
plot(X(t == -1,1),X(t == -1,2),'.b','markerSize',12);
plot(X(t == 1,1),X(t == 1,2),'.r','markerSize',12);
axis([xmin xmax ymin ymax])

%In the same plot, plot circles around the sample points.
%Different colors are used, so to better distingues in large datasets.
plot(xSamp(t(idx) == -1,1),xSamp(t(idx) == -1,2),'om','markerSize',16,'Linewidth', 2);
plot(xSamp(t(idx) == 1,1),xSamp(t(idx) == 1,2),'ok','markerSize',16,'Linewidth', 2);
hold off
legend('Class 1','Class 2', 'S-class 1', 'S-class 2');
title('Entire dataset, with sampled points circled');
xlabel('x'); ylabel('y');

end