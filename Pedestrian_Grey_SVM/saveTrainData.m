function saveTrainData(nDimensions)

load mlpr_data\data_intensity_25x50.mat;

pedTrain = ped_train_int_25x50(:, 2:1251); 
nonPedTrain = garb_train_int_25x50(:, 2:1251);
nPicTrain = length(pedTrain);

trainData = [pedTrain; nonPedTrain];
meanTrain = mean(trainData);
dimVecTrain = getDimensionsVector(trainData, nDimensions);

for i = 1:nPicTrain
    pedMatrix = pedTrain(i, :);
    nonPedMatrix = nonPedTrain(i, :);
    projPedTrain(i, :) = computeProjection(pedMatrix, meanTrain, dimVecTrain);
    projNonPedTrain(i, :) = computeProjection(nonPedMatrix, meanTrain, dimVecTrain);
end

global X;

X = [projPedTrain; projNonPedTrain];

targetPed = ones(length(projPedTrain), 1);
targetNonPed = -ones(length(projNonPedTrain), 1)
Y = [targetPed; targetNonPed];
[w, b] = primal_svm(1, Y, .5);

save('trainSpace.mat', 'meanTrain', 'dimVecTrain', 'w', 'b');
save('trainPedestrian.mat', 'projPedTrain');
save('trainNonPedestrian.mat', 'projNonPedTrain');

end