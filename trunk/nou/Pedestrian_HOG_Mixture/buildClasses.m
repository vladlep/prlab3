function [mixture1, mixture2] = buildClasses(projPedTrain, projNonPedTrain)

C = 2;

[idx1, c1, sumd1, d1] = kmeans(projPedTrain, C);
[idx2, c2, sumd2, d2] = kmeans(projNonPedTrain, C);
cov1 = cov(projPedTrain);
cov2 = cov(projNonPedTrain);

for i = 1:C
    muPed(i, :) = c1(i, :);
    prPed(i) = 1 / C;
    sigmaPed(:, :, i) = cov1;
    
    muNonPed(i, :) = c2(i, :);
    prNonPed(i) = 1 / C;
    sigmaNonPed(:, :, i) = cov2;
end

struct1 = struct('mu', muPed, 'Sigma', sigmaPed, 'PComponents', prPed);
struct2 = struct('mu', muNonPed, 'Sigma', sigmaNonPed, 'PComponents', prNonPed);
opt = statset('MaxIter', 1000);

mixture1 = gmdistribution.fit(projPedTrain, C, 'Start', struct1, 'Regularize', 1e-5, 'Options', opt);
mixture2 = gmdistribution.fit(projNonPedTrain, C, 'Start', struct2, 'Regularize', 1e-5, 'Options', opt);

end