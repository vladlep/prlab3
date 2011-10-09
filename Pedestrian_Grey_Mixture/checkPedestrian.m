function ped = checkPedestrian(inputImage, mixture1, mixture2)
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

projInput = computeProjection(inputImage, meanTrain, dimVecTrain);
posterior1 = posterior(mixture1, projInput);
posterior2 = posterior(mixture2, projInput);

if (max(posterior1) > max(posterior2))
    ped = true;
else
    ped = false;
end

end