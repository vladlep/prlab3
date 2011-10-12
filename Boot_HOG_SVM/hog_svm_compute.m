function [ SOL, B ] = hog_svm_compute( ped_train_lrf,garb_train_lrf)

addpath('..\commonFunctions');

    pedData= ped_train_lrf(:,2:1153);
    nonPedData = garb_train_lrf(:,2:1153);
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

