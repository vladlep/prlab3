% Pedestrian test set: 359 correctly identified, 141 wrongly identified
% Non-pedestrian test set: 403 correctly identified, 97 wrongly identified

clc;
clear all;
close all;

load ..\mlpr_data\data_lrf.mat;
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

pedTest = ped_test_lrf(:, 2:321); 
nonPedTest = garb_test_lrf(:, 2:321);
inputImage = nonPedTest(100, :);
isPed = checkPedestrian(inputImage);

if isPed == true
   display('Pedestrian detected.');
else
   display('Pedestrian not detected.');
end