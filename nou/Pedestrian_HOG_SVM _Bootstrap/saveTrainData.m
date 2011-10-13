function saveTrainData

load ..\mlpr_data\data_hog.mat;
load ..\mlpr_data\data_bootstrap.mat;
load bootMostDifficultPed.mat;

pedTrain = ped_train_hog(:, 2:1153); 
nonPedTrain = garb_train_hog(:, 2:1153);

% nonPedBootstrap = zeros(250, 1152);
% perm = randperm(size(garb_bootstrap_hog, 1));
% 
% for i = 1:250
%     nonPedBootstrap(i, :) = garb_bootstrap_hog(perm(i), 2:1153);
% end

nonPedBootstrap = bootMostDifficult(1:250, :);

nonPedTrain = [nonPedTrain; nonPedBootstrap];
trainData = [pedTrain; nonPedTrain];

global X;

X = [pedTrain; nonPedTrain];

targetPed = ones(size(pedTrain, 1), 1);
targetNonPed = -ones(size(nonPedTrain, 1), 1);
Y = [targetPed; targetNonPed];
[w, b] = primal_svm(1, Y, .5);

save('trainData.mat', 'w', 'b');

end