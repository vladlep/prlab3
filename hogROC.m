function [ ] = hogROC(  )
%GRAYSCALEROC Summary of this function goes here
%   Detailed explanation goes here
load mlpr_data\data_hog.mat;
addpath('.\commonFunctions');

pedTrain = ped_train_hog(:, 2:1153); 
nonPedTrain = garb_train_hog(:, 2:1153);


trainData = [pedTrain; nonPedTrain];

nrOfDimensions  = rocCompute(trainData, 0.99)

end

