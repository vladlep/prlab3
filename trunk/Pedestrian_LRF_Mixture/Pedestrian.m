clc;
clear all;
close all;

load ..\mlpr_data\data_lrf.mat;
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

[mixture1, mixture2] = buildClasses(projPedTrain, projNonPedTrain);

pedTest = ped_test_lrf(:, 2:321); 
nonPedTest = garb_test_lrf(:, 2:321);
inputImage = nonPedTest(45, :);
isPed = checkPedestrian(inputImage, mixture1, mixture2);

if isPed == true
    display('Pedestrian detected.');
else
    display('Pedestrian not detected.');
end
