function ped = checkPedestrian(inputImage)
load trainSpace.mat;
load trainPedestrian.mat;
load trainNonPedestrian.mat;

projInput = computeProjection(inputImage, meanTrain, dimVecTrain);
y = dot(w', projInput) + b;
    
if (y >= 0)
    ped = true;
else
    ped = false;
end

end