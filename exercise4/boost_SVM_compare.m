% TO DO -- e doar copiat din celelalt momentan
function [percentErrorPed_avg percentErrorNonPed_avg percentErrorPed_max percentErrorNonPed_max percentErrorPed_ideal percentErrorNonPed_ideal] = exercise4_boosted_SVM(threshold)
load ..\lrfSVM.mat;
load ..\hogSVM.mat; 
load ..\mlpr_data\data_lrf.mat;
load ..\mlpr_data\data_hog.mat; 

sol_lrf_init = SOL_init; 
b_lrf_init = B_init;
sol_lrf_boot = SOL_boot; 
b_lrf_boot = B_boot;

% the svm parameters for hog are stored in the hogSVM file and will not be
% renamed : 
%SOL_hog_init ;B_hog_init ; SOL_hog_boot; B_hog_boot

pedTestHog = ped_test_hog(:,2:1153);
nonPedTestHog = garb_test_hog(:,2:1153);
pedTestLrf = ped_test_lrf(:,2:321);
nonPedTestLrf = garb_test_lrf(:,2:321);

    errorPed = 0;
    errorPedMax = 0;
    for i=1 : 500
        valueLrf = pedTestLrf(i,:) * sol_lrf_boot + b_lrf_boot;  
        valueHog = pedTestHog(i,:) * SOL_hog_boot + B_hog_boot;
      if (valueLrf+valueHog)/2 < threshold 
             errorPed = errorPed + 1;
      end
      if (max(valueLrf,valueHog)  < threshold )
             errorPedMax = errorPedMax + 1;
      end
    end
    
    errorNonPed =0;
    errorNonPedMax = 0;
    errorNonPedIdeal = 0;
    for i=1 :  500  
       valueLrf = nonPedTestLrf(i,:) * sol_lrf_boot + b_lrf_boot;  
       valueHog = nonPedTestHog(i,:) * SOL_hog_boot + B_hog_boot;
        if ((valueLrf+ valueHog)/2> threshold)
            errorNonPed = errorNonPed + 1;
        end
         if (max(valueLrf, valueHog)> threshold)
             errorNonPedMax = errorNonPedMax +1;
         end
         if (min(valueLrf, valueHog)> threshold)
             errorNonPedIdeal = errorNonPedIdeal +1;
         end
     
    end
    
    percentErrorPed_avg =  errorPed/ 500;
    percentErrorNonPed_avg = errorNonPed/500;
   
    percentErrorPed_max =  errorPedMax/ 500;
    percentErrorNonPed_max = errorNonPedMax/500;
    
    percentErrorPed_ideal =  percentErrorPed_max;
    percentErrorNonPed_ideal = errorNonPedIdeal/500;
    
end
