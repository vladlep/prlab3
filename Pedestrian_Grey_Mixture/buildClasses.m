function [mixture1, mixture2] = buildClasses(projPedTrain, projNonPedTrain)

mixture1 = gmdistribution.fit(projPedTrain, 20, 'Start', 'randSample', 'SharedCov', true, 'CovType', 'diagonal', 'Regularize', eps);
mixture2 = gmdistribution.fit(projNonPedTrain, 20, 'Start', 'randSample', 'SharedCov', true, 'CovType', 'diagonal', 'Regularize', eps);

end