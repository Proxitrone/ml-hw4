function [confusion, sensitivity, specificity] = regression_results(data, labels, w)
%REGRESSION_RESULTS Compute confusion matrix, sensitivity and specificity
%   Detailed explanation goes here
    confusion = zeros(2);
    y = sigmoid(w'*data);
    confusion(1,1) = sum(labels == 0 & round(y)  == 0);
    confusion(1,2) = sum(labels == 0) - confusion(1,1);
    
    confusion(2,2) = sum(labels == 1 & round(y)  == 1);
    confusion(2,1) = sum(labels == 1) - confusion(2,2);
    
    sensitivity = confusion(1,1)/sum(labels == 0);
    specificity = confusion(2,2)/sum(labels == 1);
end

