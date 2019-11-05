function [two_bin_data, labels] = two_bins_data(classes_data)
%TWO_BINS_DATA Discretize the gray level value of each pixel into two bins
%   Detailed explanation goes here
    class_num = size(classes_data, 1);
    data_num = 0;
    two_bin_data = [];
    labels = [];
    for i=1:class_num
        class_size = size(classes_data{i}, 2);
        data_num = data_num + class_size;
        two_bin_data = [two_bin_data, (classes_data{i}>127)];
        labels = [labels, ones(1,class_size).*(i-1)];
    end

    
end

