function saveTrainData

load ..\mlpr_data\data_hog.mat;

pedTrain = ped_train_hog(:, 2:1153); 
nonPedTrain = garb_train_hog(:, 2:1153);

global X;

X = [pedTrain; nonPedTrain];

targetPed = ones(size(pedTrain, 1), 1);
targetNonPed = -ones(size(nonPedTrain, 1), 1);
Y = [targetPed; targetNonPed];
[w, b] = primal_svm(1, Y, .5);

save('trainData.mat', 'w', 'b');

end