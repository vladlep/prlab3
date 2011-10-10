% percent error pedestrians classification  0.3080
% error non - pedestrians classification    0.4340
% 50 iterations to train the classifier
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
hold all;
%the extreme values where selected running the testPhase on
%the training function and ploting the min and max val of f(x)
for i = -30 : 2: 30
[percentPed, percentNonPed] = testPhase(i, SOL, B,pedTest, nonPedTest);
plot(percentNonPed,1 - percentPed,'--rs','LineWidth',2,...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor','g',...
            'MarkerSize',5);
end

ylabel('Pedestrian detection rate');
xlabel('Non-pedestrians detected as pedestrians') ;

