function [percentErrorPed percentErrorNonPed ] = testPhase( threshold ,SOL, B , pedTest, nonPedTest )
%TESTPHASE Function used to test the classifer. 
%   B and SOL are the parametrs learned from by the SVM on the training
%   data

%     load mlpr_data\data_lrf.mat;
%     pedTest = ped_test_lrf(:,2:321);
%     nonPedTest = garb_test_lrf(:,2:321);
    errorPed = 0;
    max = 0;
    for i=1 : size(pedTest,1)
        if max <pedTest(i,:) *SOL + B
            max = pedTest(i,:) *SOL + B;
        end
    if pedTest(i,:) *SOL + B < threshold
        errorPed = errorPed + 1;
    end
    end
    
    errorNonPed =0;
    min = 100
    for i=1 : size(nonPedTest,1)
     if min >pedTest(i,:) *SOL + B
            min = pedTest(i,:) *SOL + B;
        end    
    if nonPedTest(i,:) * SOL + B > threshold
        errorNonPed = errorNonPed + 1;
    end
    end
    fprintf('max');
    max
    fprintf('min');
    min
    fprintf('percent error pedestrians classification ' );
    percentErrorPed =  errorPed/ size(nonPedTest,1)
    
    fprintf('error non - pedestrians classification ' );
    percentErrorNonPed = errorNonPed/size(pedTest,1)
end

