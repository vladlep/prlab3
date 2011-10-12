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

threshold =0;
errorPed = 0;

    for i=1 : 500
        valueLrf = pedTestLrf(i,:) * sol_lrf_init + b_lrf_init;  
        valueHog = pedTestHog(i,:) * SOL_hog_init + B_hog_init;
      if ((valueLrf+valueHog) /2 < threshold )
%         if (max(valueLrf,valueHog)  < threshold )
              errorPed = errorPed + 1;
      end
    end
    
    errorNonPed =0;
    for i=1 :  500  
        valueLrf = nonPedTestLrf(i,:) * sol_lrf_init + b_lrf_init;  
        valueHog = nonPedTestHog(i,:) * SOL_hog_init + B_hog_init;   
        if (valueLrf+ valueHog)> threshold
%         if (min(valueLrf, valueHog)> threshold)
            errorNonPed = errorNonPed + 1;
        end
    end
    fprintf('percent error pedestrians classification ' );
    percentErrorPed =  errorPed/ 500
    
    fprintf('error non - pedestrians classification ' );
    percentErrorNonPed = errorNonPed/500

