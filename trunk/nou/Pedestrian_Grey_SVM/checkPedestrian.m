function ped = checkPedestrian(inputImage)
load trainData.mat;

y = dot(w', inputImage) + b;
    
if (y >= 0)
    ped = true;
else
    ped = false;
end

end