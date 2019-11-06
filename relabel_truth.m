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
       % Find the list of most occuring elements
       [freq_labels,bin] = hist(res_labels(index_prev:index),unique(res_labels(index_prev:index)));
       [~,idx] = sort(-freq_labels);
       freq_labels = bin(idx);
       for j=1:numel(idx)
           in_label = false; 
           for m=1:k
                if(freq_labels(j)==k_label(m)) 
                   in_label = true;
                   break;
                end
           end
           if (in_label == false)
               k_label(k) = freq_labels(j);
               break;
           end
          
       end
%        k_label(k) = mode(res_labels(index_prev:index));

%        if sum(k_label==k_label(k))>1
%            k_label(k) = mode(res_labels(res_labels(index_prev:index)~=k_label(k)));
%        end

       new_Mu(:,k) = Mu(:,k_label(k));
       index_prev = index+1;
       
    end
    
    
end

