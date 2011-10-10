function [ ] = grayScaleROC(  )
%GRAYSCALEROC Summary of this function goes here
%   Detailed explanation goes here
load mlpr_data\data_intensity_25x50.mat;
addpath('.\commonFunctions');

pedTrain = ped_train_int_25x50(:, 2:1251); 
nonPedTrain = garb_train_int_25x50(:, 2:1251);


trainData = [pedTrain; nonPedTrain];

nrOfDimensions  = rocCompute(trainData, 0.99)

end

