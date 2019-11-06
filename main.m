%% Logistic Regression
%% Case 1
N = 50;
mx1 = 1;
my1 = 1;
mx2 = 10;
my2 = 10;

vx1 = 2;
vy1 = 2;
vx2 = 2;
vy2 = 2;

logistic_regression(N, mx1, vx1, my1, vy1, mx2, vx2, my2, vy2);

%% Case 2
N = 50;
mx1 = 1;
my1 = 1;
mx2 = 3;
my2 = 3;

vx1 = 2;
vy1 = 2;
vx2 = 4;
vy2 = 4;

logistic_regression(N, mx1, vx1, my1, vy1, mx2, vx2, my2, vy2);

%% EM

load classes_data.mat classes_data

EM_algorithm(classes_data);
