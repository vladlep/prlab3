function ped = checkPedestrian(inputImage, mixture1, mixture2, threshold)
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

projInput = computeProjection(inputImage, meanTrain, dimVecTrain);
% posterior1 = posterior(mixture1, projInput);
% posterior2 = posterior(mixture2, projInput);

probPed = pdf(mixture1, projInput);
probNonPed = pdf(mixture2, projInput);

if (probPed - probNonPed > threshold)
% if (max(posterior1) - max(posterior2) > threshold)
    ped = true;
else
    ped = false;
end

end