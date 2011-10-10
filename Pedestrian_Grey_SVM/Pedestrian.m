% percent error pedestrians classification  0.3080
% error non - pedestrians classification    0.4340

clc;
clear all;
close all;

addpath('..\commonFunctions');
load ..\mlpr_data\data_intensity_25x50.mat;

pedTrain = ped_train_int_25x50(:, 2:1251); 
nonPedTrain= garb_train_int_25x50(:, 2:1251);
trainData = [pedTrain ; nonPedTrain];

% rocCompute(trainData,0.99)

labelsPed = ped_train_int_25x50(:,1);
labelsNonPed = garb_train_int_25x50(:,1);
labels = [labelsPed; labelsNonPed];

%training phase
global  X;% defined for the svm algorithm 
X = trainData; 

[SOL,B] = primal_svm(1,labels,0.5);

%test phase
pedTest = ped_test_int_25x50(:, 2:1251); 
nonPedTest = garb_test_int_25x50(:, 2:1251);
%can loop and put different thresholds 
testPhase(0, SOL, B,pedTest, nonPedTest);

