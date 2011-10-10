% Pedestrian test set: 454 correctly identified, 46 wrongly identified
% Non-pedestrian test set: 176 correctly identified, 324 wrongly identified

clc;
clear all;
close all;

load ..\mlpr_data\data_intensity_25x50.mat;
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

% saveTrainData(23);

[mixture1, mixture2] = buildClasses(projPedTrain, projNonPedTrain);

pedTest = ped_test_int_25x50(:, 2:1251); 
nonPedTest = garb_test_int_25x50(:, 2:1251);
thresh = linspace(-1, 1, 20);

for j = 1:length(thresh)
    
    nPed = 0;
    nNonPed = 0;
    threshold = thresh(j);
    
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
    
    Y(j) = nPed / size(pedTest, 1);
    X(j) = 1 - (nNonPed / size(nonPedTest, 1));

end

figure(1);
hold all;
plot(X, Y, 'o-', 'LineWidth', 2, 'Color', 'k', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
xlabel('False negative rate');
ylabel('True positive rate');
grid on;

% display(['Pedestrian - correctly classified: ', num2str(nPed / size(pedTest, 1) * 100), '%, wrongly classified: ', num2str((1 - nPed / size(pedTest, 1)) * 100), '%']);
% display(['Non-pedestrian - correctly classified: ', num2str(nNonPed / size(nonPedTest, 1) * 100), '%, wrongly classified: ', num2str((1 - nNonPed / size(nonPedTest, 1)) * 100), '%']);

% inputImage = pedTest(25, :);
% isPed = checkPedestrian(inputImage, mixture1, mixture2);
% inputImage = reshape(inputImage, [50, 25]);
% imshow(inputImage, []);
% 
% if isPed == true
%     display('Pedestrian detected.');
% else
%     display('Pedestrian not detected.');
% end