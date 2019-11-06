function error = imagination_print(classifier, fileID, iterations, diff, mode)
%IMAGINATION_PRINT Summary of this function goes here
%   Detailed explanation goes here
    error = 1;
    
    feature_num = size(classifier, 1);
    class_num = size(classifier, 2);
    
    
%     disp('Imagination of numbers in Bayesian classifier:');
%     disp(' ');
    %fprintf(fileID, 'Imagination of numbers in Bayesian classifier:\n');
    
    for i=1:class_num
        class_representation = zeros(sqrt(feature_num));
        class_representation(classifier(:, i)>0.5) = 1;
        
        
%         disp(bayes_representation');
%         disp(' ');
        if mode == 0
            fprintf(fileID, ['class ', num2str(i-1), ':\n']);
        elseif mode == 1
            fprintf(fileID, ['labeled class ', num2str(i-1), ':\n']);
        end
        col_string = '';
        class_representation = class_representation';
        [row_num,col_num] = size(class_representation);
        for r = 1:row_num
            
            for c = 1:col_num
                fprintf(fileID, '%d ', round(class_representation(r,c)));
            end
            fprintf(fileID, '\n');
        end
        fprintf(fileID, '\n');
        
    end
    fprintf(fileID, ['No. of Iteration: ', num2str(iterations), ', Difference: ', num2str(diff, 12), '\n\n']);
    fprintf(fileID, '---------------------------------------------------------------\n\n');
    error = 0;
    
end

