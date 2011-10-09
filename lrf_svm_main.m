function [  ] = lrf_svm_main( )
% main function fot the svm algortihm and LRF feature
% runs and evaluates the combination

load mlpr_data\data_lrf.mat;
    pedData= ped_train_lrf(:,2:321);
    nonPedData = garb_train_lrf(:,2:321);
    trainData = [pedData; nonPedData];
    size(trainData);
    
%     rocCompute(trainData,0.99)
   
    %training phase
    global  X;% defined for the svm algorithm 
    X = trainData; 
    pedLabels =  ped_train_lrf(:,1);
    nonPedLabels =  garb_train_lrf(:,1);
    labels = [pedLabels; nonPedLabels];
    [SOL,B] = primal_svm(1,labels,0.5);
    
    % test phase   
    pedTest = ped_test_lrf(:,2:321);
    nonPedTest = garb_test_lrf(:,2:321);
    errorPed = 0;
    for i=1 : size(pedTest,1)
    if pedTest(i,:) *SOL + B < 0
        errorPed = errorPed + 1;
    end
    end
    
    errorNonPed =0;
    for i=1 : size(pedTest,1)
    if nonPedTest(i,:) * SOL + B > 0
        errorNonPed = errorNonPed + 1;
    end
    end
    fprintf('error pedestrians classification ' );
    errorPed 
    
    fprintf('error non - pedestrians classification ' );
    errorNonPed
end

