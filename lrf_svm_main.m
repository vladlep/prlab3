function [  ] = lrf_svm_main( )
% main function fot the svm algortihm and LRF feature
% runs and evaluates the combination

load mlpr_data\data_lrf.mat;
    pedData= ped_train_lrf(:,2:321);
    nonPedData = garb_train_lrf(:,2:321);
    trainData = [pedData; nonPedData];
    size(trainData)
    
    rocCompute(trainData,0.99)
   
    global  X;% defined for the svm algorithm 
    X = trainData; 
    pedLabels =  ped_train_lrf(:,1);
    nonPedLabels =  garb_train_lrf(:,1);
    labels = [pedLabels; nonPedLabels];
   [SOL,B] = primal_svm(1,labels,0.5)
   
end

