function saveTrainData

load ..\mlpr_data\data_lrf.mat;

pedTrain = ped_train_lrf(:, 2:321); 
nonPedTrain = garb_train_lrf(:, 2:321);

global X;

X = [pedTrain; nonPedTrain];

targetPed = ones(size(pedTrain, 1), 1);
targetNonPed = -ones(size(nonPedTrain, 1), 1);
Y = [targetPed; targetNonPed];
[w, b] = primal_svm(1, Y, .5);

save('trainData.mat', 'w', 'b');

end