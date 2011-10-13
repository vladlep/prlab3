% Pedestrian test set: 347 correctly identified, 153 wrongly identified
% Non-pedestrian test set: 329 correctly identified, 171 wrongly identified

clc;
clear all;
close all;

% saveTrainData;

load ..\mlpr_data\data_intensity_25x50.mat;

pedTest = ped_test_int_25x50(:, 2:1251); 
nonPedTest = garb_test_int_25x50(:, 2:1251);

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

display(['Pedestrian - correctly classified: ', num2str(nPed / size(pedTest, 1) * 100), '%, wrongly classified: ', num2str((1 - nPed / size(pedTest, 1)) * 100), '%']);
display(['Non-pedestrian - correctly classified: ', num2str(nNonPed / size(nonPedTest, 1) * 100), '%, wrongly classified: ', num2str((1 - nNonPed / size(nonPedTest, 1)) * 100), '%']);

TP = nPed;
FN = size(pedTest, 1) - nPed;
TN = nNonPed;
FP = size(nonPedTest, 1) - nNonPed;

confussion = [TP FN; FP TN]
