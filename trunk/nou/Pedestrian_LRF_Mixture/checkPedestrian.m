function ped = checkPedestrian(inputImage, mixture1, mixture2, threshold)
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

projInput = computeProjection(inputImage, meanTrain, dimVecTrain);
probPed = pdf(mixture1, projInput);
probNonPed = pdf(mixture2, projInput);

if (probPed - probNonPed > threshold)
    ped = true;
else
    ped = false;
end

end