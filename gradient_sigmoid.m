function y = gradient_sigmoid(x)
%GRADIENT_SIGMOID Derivative of a sigmoid function
%   Write the derivative of sigmoid in terms of sigmoid
    y = sigmoid(x) * (1- sigmoid(x));
end

