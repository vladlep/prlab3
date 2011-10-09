function saveTrainData(nDimensions)

load ..\mlpr_data\data_lrf.mat;

pedTrain = ped_train_lrf(:, 2:321); 
nonPedTrain = garb_train_lrf(:, 2:321);
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

save('trainSpace.mat', 'meanTrain', 'dimVecTrain');
save('trainPedestrian.mat', 'projPedTrain');
save('trainNonPedestrian.mat', 'projNonPedTrain');

end