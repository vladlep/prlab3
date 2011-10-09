% Pedestrian test set: 343 correctly identified, 147 wrongly identified
% Non-pedestrian test set: 366 correctly identified, 134 wrongly identified

clc;
clear all;
close all;

load ..\mlpr_data\data_hog.mat;
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

pedTest = ped_test_hog(:, 2:1153); 
nonPedTest = garb_test_hog(:, 2:1153);
inputImage = nonPedTest(300, :);
isPed = checkPedestrian(inputImage);

if isPed == true
   display('Pedestrian detected.');
else
   display('Pedestrian not detected.');
end