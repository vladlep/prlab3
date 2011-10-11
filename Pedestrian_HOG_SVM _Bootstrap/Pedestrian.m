% Pedestrian test set: 343 correctly identified, 147 wrongly identified
% Non-pedestrian test set: 366 correctly identified, 134 wrongly identified

clc;
clear all;
close all;

load ..\mlpr_data\data_hog.mat;
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

% saveTrainData(50);

pedTest = ped_test_hog(:, 2:1153); 
nonPedTest = garb_test_hog(:, 2:1153);

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

