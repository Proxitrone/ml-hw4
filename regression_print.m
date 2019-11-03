function error = regression_print(C, Se, Sp, w)
%REGRESSION_PRINT Summary of this function goes here
%   Detailed explanation goes here
    disp('w:');
    for i=1:size(w,1)
       disp(w(i)); 
    end
    disp(' ');
    disp('Confusion Matrix:');
    disp('             Predict cluster 1  Predict cluster 2');
    disp(['Is cluster 1       ', num2str(C(1,1)), '              ', num2str(C(1,2))]);
    disp(['Is cluster 2       ', num2str(C(2,1)), '              ', num2str(C(2,2))]);
    disp(' ');
    disp(['Sensitivity (Successfully predict cluster 1): ', num2str(Se,5)]);
    disp(['Specificity (Successfully predict cluster 2): ', num2str(Sp,5)]);
    disp(' ');
    disp('-------------------------------------');
    error = 0;
end

