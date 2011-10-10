function ped = checkPedestrian(inputImage, mixture1, mixture2, threshold)
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

projInput = computeProjection(inputImage, meanTrain, dimVecTrain);
posterior1 = posterior(mixture1, projInput);
posterior2 = posterior(mixture2, projInput);

probPed = dot(posterior1, mixture1.PComponents);
probNonPed = dot(posterior2, mixture2.PComponents);

if (probPed - probNonPed > threshold)
    ped = true;
else
    ped = false;
end

end