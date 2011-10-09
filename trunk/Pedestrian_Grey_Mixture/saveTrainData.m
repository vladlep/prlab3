function saveTrainData(nDimensions)

load ..\mlpr_data\data_intensity_25x50.mat;

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

save('trainSpace.mat', 'meanTrain', 'dimVecTrain');
save('trainPedestrian.mat', 'projPedTrain');
save('trainNonPedestrian.mat', 'projNonPedTrain');

end