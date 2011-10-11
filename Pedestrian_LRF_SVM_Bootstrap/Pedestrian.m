% Pedestrian test set: 359 correctly identified, 141 wrongly identified
% Non-pedestrian test set: 403 correctly identified, 97 wrongly identified

clc;
clear all;
close all;

load ..\mlpr_data\data_lrf.mat;
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

% saveTrainData(50);

pedTest = ped_test_lrf(:, 2:321); 
nonPedTest = garb_test_lrf(:, 2:321);

nPed = 0;
nNonPed = 0;

for i = 1:size(pedTest, 1)
    inputImage = pedTest(i, :);
    isPed = checkPedestrian(inputImage);
    
    if isPed == true
        nPed = nPed + 1;
    end
end

for i = 1:size(nonPedTest, 1)
    inputImage = nonPedTest(i, :);
    isPed = checkPedestrian(inputImage);
    
    if isPed == false
        nNonPed = nNonPed + 1;
    end
end
