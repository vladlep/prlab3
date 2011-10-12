function [percentErrorPed percentErrorNonPed ] = testPhase( threshold ,SOL, B , pedTest, nonPedTest )
%TESTPHASE Function used to test the classifer. 
%   B and SOL are the parametrs learned from by the SVM on the training
%   data

    errorPed = 0;
    for i=1 : size(pedTest,1)
      if (pedTest(i,:) * SOL + B < threshold )
        errorPed = errorPed + 1;
      end
    end
    
    errorNonPed =0;
    for i=1 : size(nonPedTest,1)  
    if nonPedTest(i,:) * SOL + B > threshold
        errorNonPed = errorNonPed + 1;
    end
    end
%     fprintf('percent error pedestrians classification ' );
    percentErrorPed =  errorPed/ size(nonPedTest,1);
    
%     fprintf('error non - pedestrians classification ' );
    percentErrorNonPed = errorNonPed/size(pedTest,1);
end

