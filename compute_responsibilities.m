function responisbilities = compute_responsibilities(data, Mu, lambda)
%COMPUTE_RESPONSIBILITIES Summary of this function goes here
%   Detailed explanation goes here
    N = size(data, 2);
    class_num = size(lambda, 1);
    responisbilities = ones(class_num, size(data,2)).*1/class_num;
    for n=1:N
        p_x_mu_lambda = 0;
            
        for k=1:class_num
            p_x_mu_lambda = p_x_mu_lambda + lambda(k)*my_bernoulli(data(:,n), Mu(:,k));
                
        end
            
        for k=1:class_num
            if p_x_mu_lambda == 0
                disp(['Datapoint ', num2str(n), ' gives us NaN']);
                responisbilities(k,n) = responisbilities(k,n-1);
            else
                responisbilities(k,n) = (lambda(k)*my_bernoulli(data(:,n), Mu(:,k)))/(p_x_mu_lambda);
            end
        end
    end
end

