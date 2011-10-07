% Pedestrian test set: 347 correctly identified, 153 wrongly identified
% Non-pedestrian test set: 329 correctly identified, 171 wrongly identified

clc;
clear all;
close all;

load ..\mlpr_data\data_intensity_25x50.mat;
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

pedTest = ped_test_int_25x50(:, 2:1251); 
nonPedTest = garb_test_int_25x50(:, 2:1251);
inputImage = pedTest(250, :);
isPed = checkPedestrian(inputImage);
inputImage = reshape(inputImage, [50, 25]);
imshow(inputImage, []);

if isPed == true
   display('Pedestrian detected.');
else
   display('Pedestrian not detected.');
end
