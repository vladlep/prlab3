clc;
clear all;
close all;

% saveTrainData(37);

load ..\mlpr_data\data_hog.mat;
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

[mixture1, mixture2] = buildClasses(projPedTrain, projNonPedTrain);

pedTest = ped_test_hog(:, 2:1153); 
nonPedTest = garb_test_hog(:, 2:1153);

thresh = linspace(-1, 1, 15);
lenThresh = length(thresh);
X = zeros(lenThresh, 1);
Y = zeros(lenThresh, 1);

for j = 1:lenThresh
    
    threshold = thresh(j);
    nPed = 0;
    nNonPed = 0;
    
    for i = 1:size(pedTest, 1)
        inputImage = pedTest(i, :);
        isPed = checkPedestrian(inputImage, mixture1, mixture2, threshold);
    
        if isPed == true
            nPed = nPed + 1;
        end
    end
    
    for i = 1:size(nonPedTest, 1)
        inputImage = nonPedTest(i, :);
        isPed = checkPedestrian(inputImage, mixture1, mixture2, threshold);
    
        if isPed == false
            nNonPed = nNonPed + 1;
        end
    end
    
    Y(j) = nPed / 500;
    X(j) = (size(nonPedTest, 1) - nNonPed) / 500;
end
    
display(['Pedestrian - correctly classified: ', num2str(nPed / size(pedTest, 1) * 100), '%, wrongly classified: ', num2str((1 - nPed / size(pedTest, 1)) * 100), '%']);
display(['Non-pedestrian - correctly classified: ', num2str(nNonPed / size(nonPedTest, 1) * 100), '%, wrongly classified: ', num2str((1 - nNonPed / size(nonPedTest, 1)) * 100), '%']);

TP = nPed;
FN = size(pedTest, 1) - TP;
TN = nNonPed;
FP = size(nonPedTest, 1) - TN;

confussion = [TP FN; FP TN]
