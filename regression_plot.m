function error = regression_plot(data, PHI, labels, w_grad, w_newt)
%REGRESSION_PLOT Plot ground truth and results of logistic regression by 2
%methods
%   Detailed explanation goes here
    figure;
    %% Ground Truth
    subplot(1, 3, 1);
    
    % Class 0
    c0 = data(:,labels==0);
    s = scatter(c0(2,:), c0(1,:), 'filled');
    s.MarkerFaceColor = [1, 0, 0];
    hold on;
    %Class 1
    c1 = data(:,labels==1);
    s = scatter(c1(2,:), c1(1,:), 'filled');
    s.MarkerFaceColor = [0, 0, 1];
    title('Ground truth');
    hold off;
    %% Gradient descent
    subplot(1, 3, 2);
    y = sigmoid(w_grad'*PHI);
    hold on;
    % Class 0
    c0 = data(:,round(y)==0);
    s = scatter(c0(2,:), c0(1,:), 'filled');
    s.MarkerFaceColor = [1, 0, 0];
    
    %Class 1
    c1 = data(:,round(y)==1);
    s = scatter(c1(2,:), c1(1,:), 'filled');
    s.MarkerFaceColor = [0, 0, 1];
    title('Gradient descent');
    hold off;
    %% Newton's method
    subplot(1, 3, 3);
    hold on;
    y = sigmoid(w_newt'*PHI);
    % Class 0
    c0 = data(:,round(y)==0);
    s = scatter(c0(2,:), c0(1,:), 'filled');
    s.MarkerFaceColor = [1, 0, 0];
    
    %Class 1
    c1 = data(:,round(y)==1);
    s = scatter(c1(2,:), c1(1,:), 'filled');
    s.MarkerFaceColor = [0, 0, 1];
    title('Newton''s method');
    hold off;
end

