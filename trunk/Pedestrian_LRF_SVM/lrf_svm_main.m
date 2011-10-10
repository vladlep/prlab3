function [  ] = lrf_svm_main( )
% main function fot the svm algortihm and LRF feature
% runs and evaluates the combination
% percent error pedestrians classification   0.3060
% error non - pedestrians classification     0.1780

clc;
clear all;
close all;

addpath('..\commonFunctions');
load ..\mlpr_data\data_lrf.mat;
    pedData= ped_train_lrf(:,2:321);
    nonPedData = garb_train_lrf(:,2:321);
    trainData = [pedData; nonPedData];
    size(trainData);
    
    rocCompute(trainData,0.99)
   
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
    
    testPhase(0, SOL, B,pedTest, nonPedTest);
    
end

