function saveTrainData

load ..\mlpr_data\data_intensity_25x50.mat;

pedTrain = ped_train_int_25x50(:, 2:1251); 
nonPedTrain = garb_train_int_25x50(:, 2:1251);

global X;

X = [pedTrain; nonPedTrain];

targetPed = ones(size(pedTrain, 1), 1);
targetNonPed = -ones(size(nonPedTrain, 1), 1);
Y = [targetPed; targetNonPed];
[w, b] = primal_svm(1, Y, .5);

save('trainData.mat', 'w', 'b');

end