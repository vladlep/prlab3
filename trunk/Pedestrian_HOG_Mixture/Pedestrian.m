clc;
clear all;
close all;

load ..\mlpr_data\data_hog.mat;
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

[mixture1, mixture2] = buildClasses(projPedTrain, projNonPedTrain);

pedTest = ped_test_hog(:, 2:1153); 
nonPedTest = garb_test_hog(:, 2:1153);
inputImage = pedTest(205, :);
isPed = checkPedestrian(inputImage, mixture1, mixture2);

if isPed == true
    display('Pedestrian detected.');
else
    display('Pedestrian not detected.');
end