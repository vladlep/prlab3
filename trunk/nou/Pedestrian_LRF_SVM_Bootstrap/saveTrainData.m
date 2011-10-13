function saveTrainData

load ..\mlpr_data\data_lrf.mat;
load ..\mlpr_data\data_bootstrap.mat;
load bootMostDifficultPed.mat;

pedTrain = ped_train_lrf(:, 2:321); 
nonPedTrain = garb_train_lrf(:, 2:321);

% nonPedBootstrap = zeros(250, 320);
% perm = randperm(size(garb_bootstrap_lrf, 1));
% 
% for i = 1:250
%     nonPedBootstrap(i, :) = garb_bootstrap_lrf(perm(i), 2:321);
% end

nonPedBootstrap = bootMostDifficult(1:250, :);

nonPedTrain = [nonPedTrain; nonPedBootstrap];
trainData = [pedTrain; nonPedTrain];

global X;

X = [pedTrain; nonPedTrain];

targetPed = ones(length(pedTrain), 1);
targetNonPed = -ones(length(nonPedTrain), 1);
Y = [targetPed; targetNonPed];
[w, b] = primal_svm(1, Y, .5);

save('trainData.mat', 'w', 'b');

end