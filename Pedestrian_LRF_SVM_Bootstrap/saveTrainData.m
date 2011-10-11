function saveTrainData(nDimensions)

load ..\mlpr_data\data_lrf.mat;
load ..\mlpr_data\data_bootstrap.mat;
load bootMostDifficultPed.mat;

pedTrain = ped_train_lrf(:, 2:321); 
nonPedTrain = garb_train_lrf(:, 2:321);

nonPedBootstrap = zeros(250, 320);
perm = randperm(size(garb_bootstrap_lrf, 1));

for i = 1:250
    nonPedBootstrap(i, :) = garb_bootstrap_lrf(perm(i), 2:321);
end

% nonPedBootstrap = bootMostDifficult(1:250, :);

nonPedTrain = [nonPedTrain; nonPedBootstrap];
nPedTrain = size(pedTrain, 1);
nNonPedTrain = size(nonPedTrain, 1);

trainData = [pedTrain; nonPedTrain];
meanTrain = mean(trainData);
dimVecTrain = getDimensionsVector(trainData, nDimensions);

for i = 1:nPedTrain
    pedMatrix = pedTrain(i, :);
    projPedTrain(i, :) = computeProjection(pedMatrix, meanTrain, dimVecTrain);
end

for i = 1:nNonPedTrain
    nonPedMatrix = nonPedTrain(i, :);
    projNonPedTrain(i, :) = computeProjection(nonPedMatrix, meanTrain, dimVecTrain);
end

global X;

X = [projPedTrain; projNonPedTrain];

targetPed = ones(length(projPedTrain), 1);
targetNonPed = -ones(length(projNonPedTrain), 1);
Y = [targetPed; targetNonPed];
[w, b] = primal_svm(1, Y, .5);

save('trainSpace.mat', 'meanTrain', 'dimVecTrain', 'w', 'b');
save('trainPedestrian.mat', 'projPedTrain');
save('trainNonPedestrian.mat', 'projNonPedTrain');

end