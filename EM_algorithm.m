function [C, Se, Sp] = EM_algorithm(classes_data)
%EM_ALGORITHM Summary of this function goes here
%   Detailed explanation goes here

    %rng(10);
    [data, labels] = two_bins_data(classes_data);
    var_size = size(data, 1);
    N = size(data, 2);
    class_num = size(classes_data, 1);
    fileID = fopen('EM_result.txt', 'w');
    % Responsibilities
    W_old = ones(class_num, size(data,2)).*1/class_num;
    W_new = W_old;
    result_labels = zeros(size(labels));
    epsilon = 20;
    % Each image (28x28 -> 784x1) is a set of D=784 binary variables, each
    % governed by a Bernoulli distribution with parameter mu_i
    % Having 10 classes, we need bernoulli parameters for each class, so 
    %Mu = 1/var_size * ones(var_size, class_num);
    Mu = rand(var_size, class_num)*0.5 + 0.25;
    Mu = Mu./sum(Mu, 2);
    lambda = 1/class_num * ones(class_num, 1);
    iterations = 1;
    objective = 10e5;
    while (1)
        % Finite mixture of bernoulli distributions is given by
        
        W_new = compute_responsibilities(data, Mu, lambda);
        
        N_k = sum(W_new, 2);
        
        x_k = zeros(size(Mu));
        for k=1:class_num
            x_k(:,k) = 1/N_k(k) .* sum(W_new(k,:).*data, 2);
        end
        
        Mu = x_k;
        Mu(Mu==0) = min(Mu(Mu>0), [], 'all');
        
        lambda = N_k./N;
        
        z = zeros(size(W_new));
        [~, idx] = max(W_new,[], 1);
        z(sub2ind(size(W_new), idx, 1:length(idx))) = 1;
        
        objective = [objective, EM_objective(z, lambda, data, Mu)];
        diff = abs(objective(end) - objective(end-1));
        if diff<epsilon && iterations>10
            mode = 0;
            imagination_print(Mu, fileID, iterations, diff, mode);
            [~, result_labels] = max(W_new, [], 1);
            mode = 1;
            Mu  = relabel_truth(Mu, result_labels, labels, classes_data);
            W_new = compute_responsibilities(data, Mu, lambda);
            [~, result_labels] = max(W_new, [], 1);
            imagination_print(Mu, fileID, iterations, diff, mode);
            confusion_print(fileID, result_labels-1, labels, iterations);
            break;
        end
        if (iterations==1)
            mode = 0;
            imagination_print(Mu, fileID, iterations, diff, mode);
        end
        iterations = iterations + 1;
    end
    fclose(fileID);
    figure;
    plot(objective);
end

