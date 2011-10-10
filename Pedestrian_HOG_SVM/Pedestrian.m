% percent error pedestrians classification     0.3200
% error non - pedestrians classification       0.1900
% 6 iterations
% main function fot the svm algortihm and HOG feature

clc;
clear all;
close all;

addpath('..\commonFunctions');
load ..\mlpr_data\data_hog.mat;

pedTrain = ped_train_hog(:, 2:1153); 
nonPedTrain= garb_train_hog(:, 2:1153);
trainData = [pedTrain ; nonPedTrain];

% rocCompute(trainData,0.99)

labelsPed = ped_train_hog(:,1);
labelsNonPed = garb_train_hog(:,1);
labels = [labelsPed; labelsNonPed];
%training phase
global  X;% defined for the svm algorithm 
X = trainData; 

[SOL,B] = primal_svm(1,labels,0.5);

%test phase
pedTest = ped_test_hog(:, 2:1153); 
nonPedTest = garb_test_hog(:, 2:1153);
%can loop and put different thresholds 
hold all;
for i = -2.8 : 0.2: 3.2
[percentPed, percentNonPed] = testPhase(i, SOL, B,pedTest, nonPedTest);
plot(percentNonPed,1 - percentPed,'--rs','LineWidth',2,...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor','g',...
            'MarkerSize',5);
end

ylabel('Pedestrian detection rate');
xlabel('Non-pedestrians detected as pedestrians') ;
