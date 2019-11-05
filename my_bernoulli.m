function p_x_mu = my_bernoulli(x,mu)
%BERNOULLI Summary of this function goes here
%   Detailed explanation goes here

    p_x_mu = prod( (mu.^x).*((1-mu).^(1-x)) );
end

