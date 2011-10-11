function [mixture1, mixture2] = buildClasses(projPedTrain, projNonPedTrain)

opt = statset('MaxIter', 300);
mixture1 = gmdistribution.fit(projPedTrain, 5, 'Start', 'randSample', 'CovType', 'diagonal', 'Regularize', eps);
mixture2 = gmdistribution.fit(projNonPedTrain, 5, 'Start', 'randSample',  'CovType','diagonal', 'Regularize', eps);

end