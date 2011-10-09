function [nrDimensions] = rocCompute(trainData, percentOfKeepedInfomation)
% calculate how many dimensions to use , in order to keep the specified
% amount of information
% trainData - a matrix of the training data
% percentOfKeepedInformation - the amount of information you want have from
% the total. E.g. 90% => after dimensionality reduction you will have 90%
% of information so only 10% will be lost

    sizeTrain = size(trainData,1);
    meanTrain = mean(trainData); 
    % repeat the mean to create a matrix with the values from the mean on
    % all the lines. Need in order to do the substractions.
    meanMatrix = repmat(meanTrain,sizeTrain ,1); 

    X = trainData - meanMatrix;
    matrix = X' * X;

    values = eig(matrix);

    sortedValues = sort(values,'descend');
    sizeSortVal = size(sortedValues);
    suma = zeros(sizeSortVal);
    suma(1) = sortedValues(1);
    for i=2:sizeSortVal
        suma(i) = suma(i-1) + sortedValues(i);  
    end
    nrDimensions = sizeSortVal; % default init, in case some parameters are send wrong
    infoKeep = percentOfKeepedInfomation * suma(sizeSortVal);
   for i =1 :(sizeSortVal -1) 
       if infoKeep <= suma(i)
           nrDimensions = i;
           break;
       end
   end

   
   plot(suma/ suma(i)); % normalize plot ;
   xlabel('Number of dimensions ') % dimensions= eigenvalues
   ylabel('Influence of first X dimension') ;

end