function [C, Se, Sp] = confusion_print(fileID, result_labels, labels, iterations)
%CONFUSION_PRINT Compute confusion matrix, sensitivity and specificity for
%all classes and print them out
%   Detailed explanation goes here
    class_num = numel(unique(labels));
    C = cell(class_num, 1);
    Se = cell(class_num, 1);
    Sp = cell(class_num, 1);
    data_num = size(labels,2);
    
    for i=1:class_num
        C{i}(1, 1) = sum(labels==(i-1)&result_labels==(i-1));
        C{i}(1, 2) = sum(labels==(i-1)&result_labels~=(i-1));
        
        C{i}(2, 2) = sum(labels~=(i-1)&result_labels~=(i-1));
        C{i}(2, 1) = sum(labels~=(i-1)&result_labels==(i-1));
        
        Se{i} = C{i}(1, 1)/(C{i}(1, 1)+C{i}(1, 2));
        Sp{i} = C{i}(2,2)/(C{i}(2, 1)+C{i}(2, 2));
        numstr = num2str(i-1);
        fprintf(fileID, ['Confusion Matrix ', numstr, ':\n']);
        fprintf(fileID, ['              Predict number ',numstr,'  Predict not number ', numstr, '\n']);
        fprintf(fileID, ['Is number    ',numstr, '       ', num2str(C{i}(1, 1)), '           ', num2str(C{i}(1, 2)), '\n']);
        fprintf(fileID, ['Isn''t number ',numstr, '       ', num2str(C{i}(2, 1)), '           ', num2str(C{i}(2, 2)), '\n\n']);
        fprintf(fileID, ['Sensitivity (Successfully predict number ', numstr, ')    :', num2str(Se{i},5),'\n']);
        fprintf(fileID, ['Specificity (Successfully predict not number ', numstr, '):', num2str(Sp{i},5), '\n\n']);
        fprintf(fileID, '-------------------------------------------------------------\n\n');
    end
    
    fprintf(fileID, ['Total iteration to converge: ', num2str(iterations), '\n']);
    acc = sum(labels==result_labels)/data_num;
    fprintf(fileID, ['Total error rate: ', num2str(acc, 12), '\n']);
end

