function [C, Se, Sp] = logistic_regression(N, mx1, vx1, my1, vy1, mx2, vx2, my2, vy2)
%LOGISTIC_REGRESSION Generate data points from 2 clusters and use logistic
%regression to separate them
%   Detailed explanation goes here
    D1 = zeros(2, N);
    D2 = zeros(2, N);
    data = zeros(2, 2*N);
    PHI = zeros(3, 2*N);
    labels = zeros(1, 2*N);
    iteration = 1;
    % Stepsize for gradient descent
    alpha = 1;
    % Termination criteria coefficient
    epsilon = 1e-3;
    for i=1:N
        D1(1, i) = uni_gauss_dg(mx1, vx1);
        D1(2, i) = uni_gauss_dg(my1, vy1);
        
        D2(1, i) = uni_gauss_dg(mx2, vx2);
        D2(2, i) = uni_gauss_dg(my2, vy2);
        % Create a training set example with class labels (0, 1)
        data(1,2*i-1) = D1(1, i);
        data(2,2*i-1) = D1(2, i);
        labels(1,2*i-1) = 0;
        
        data(1,2*i) = D2(1, i);
        data(2,2*i) = D2(2, i);
        labels(1,2*i) = 1;
    end
    PHI(1,:) = 1;
    PHI(2:3,:) = data;
    
    % Initialize weight vector for our classification
    E_old = 1;
    %% Gradient Descent
    w_old = zeros(size(PHI,1), 1);
    while (1)
        % We now need to train w so that sigma(w'*PHI) gives us correct
        % predictions
        % Cross-entropy error function
        y = sigmoid(w_old'*PHI);
        E_new = - sum(labels.*log(y)+(1-labels).*log(1-y));
        % Gradient of it
        grad_E = PHI*(y-labels)';
        % Alpha depending on the iteration
        alpha = 1/sqrt(iteration);
%         if (mod(iteration, 10) == 0)
%             alpha = alpha /2;
%         end
        %% Gradient descent step
        w_new = w_old - alpha*grad_E;

        %% Convergence condition based on the cross-entropy function
        if abs(w_new-w_old)< epsilon
            % Perform prediction and compose matrices
            [C, Se, Sp] = regression_results(PHI, labels, w_new);
            disp('Gradient descent:');
            regression_print(C, Se, Sp, w_new);
            w_grad = w_new;
            break;
        end
        w_old = w_new;
        E_old = E_new;
        iteration = iteration+1;
    end
    w_old = zeros(size(PHI,1), 1);
    iteration = 0;
    %% Newton's method
    while (1)
        % We now need to train w so that sigma(w'*PHI) gives us correct
        % predictions
        % Cross-entropy error function
        y = sigmoid(w_old'*PHI);
        E_new = - sum(labels.*log(y)+(1-labels).*log(1-y));
        % Gradient of it
        grad_E = PHI*(y-labels)';
        % Diagonal weight matrix R
        R = diag(y.*(1-y));
        % Hessian 
        H = PHI*R*PHI';
        %% Newton's method update of w
        if cond(H)<50
            % If hessian is non-singular, apply Newton's method to update w
            w_new = w_old - inv(H)*grad_E;
        else
            % If hessian is singular, apply gradient descent 
            % Alpha depending on the iteration
            alpha = 0.1;
            w_new = w_old - alpha*grad_E;
        end
        %% Convergence condition based on the cross-entropy function
        if abs(w_new-w_old)< epsilon
            [C, Se, Sp] = regression_results(PHI, labels, w_new);
            disp('Newton''s Method:');
            regression_print(C, Se, Sp, w_new);
            w_newt = w_new;
            break;
        end
        w_old = w_new;
        E_old = E_new;
        iteration = iteration+1;
    end
    regression_plot(data, PHI, labels, w_grad, w_newt);
end

