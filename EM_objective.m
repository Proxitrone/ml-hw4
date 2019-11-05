function log_likelihood = EM_objective(z,lambda, data, Mu)
%EM_OBJECTIVE Compute the complete log-likelihood function
%   Detailed explanation goes here
    log_likelihood=0;
    N = size(data,2);
    K = size(Mu, 2);
    for n=1:N
        K_sum = 0;
        for k=1:K
            D_sum = sum(data(:,n).*log(Mu(:, k)) + (1- data(:,n)).*log(1-Mu(:, k)));
            K_sum = K_sum+ z(k,n)*(log(lambda(k))+D_sum);
        end
        log_likelihood = log_likelihood+K_sum;
    end
end

