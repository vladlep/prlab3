function [ SOL, B ] = lrf_svm_compute( ped_train_lrf,garb_train_lrf)
% main function fot the svm algortihm and LRF feature
% runs and evaluates the combination
% percent error pedestrians classification   0.3060
% error non - pedestrians classification     0.1780


addpath('..\commonFunctions');

    pedData= ped_train_lrf(:,2:321);
    nonPedData = garb_train_lrf(:,2:321);
    trainData = [pedData; nonPedData];
    size(trainData);
   
    %training phase
    global  X;% defined for the svm algorithm 
    X = trainData; 
    pedLabels =  ped_train_lrf(:,1);
    nonPedLabels =  garb_train_lrf(:,1);
    labels = [pedLabels; nonPedLabels];
    [SOL,B] = primal_svm(1,labels,0.5);
    
  
   

end

