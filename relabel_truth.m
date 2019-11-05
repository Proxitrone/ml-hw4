function [new_Mu, res_labels] = relabel_truth(Mu, res_labels, true_labels, classes_data)
%RELABEL_TRUTH Relabel the result according to the true labels
%   Try to label our known classes with learned classifier Mu, the maximum
%   number of elements classified from a class are assigned the true label
    class_num = size(classes_data, 1);
    k_label = zeros(class_num, 1);
    data_in_class_num = zeros(class_num, 1);
    new_Mu = zeros(size(Mu));
    for k=1:class_num
        data_in_class_num(k) = size(classes_data{k}, 2);       
    end
    index_prev = 1;
    for k=1:class_num
       index=0;
       for i=1:k
          index = index+ data_in_class_num(i);
       end
       k_label(k) = mode(res_labels(index_prev:index));
       index_prev = index+1;
       new_Mu(:,k) = Mu(:,k_label(k));
    end
    
    
end

