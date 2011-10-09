% Pedestrian test set: 454 correctly identified, 46 wrongly identified
% Non-pedestrian test set: 176 correctly identified, 324 wrongly identified

clc;
clear all;
close all;

load ..\mlpr_data\data_intensity_25x50.mat;
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

[mixture1, mixture2] = buildClasses(projPedTrain, projNonPedTrain);

pedTest = ped_test_int_25x50(:, 2:1251); 
nonPedTest = garb_test_int_25x50(:, 2:1251);
inputImage = pedTest(25, :);
isPed = checkPedestrian(inputImage, mixture1, mixture2);
inputImage = reshape(inputImage, [50, 25]);
imshow(inputImage, []);

if isPed == true
    display('Pedestrian detected.');
else
    display('Pedestrian not detected.');
end