function dimVec = getDimensionsVector(data, nDimensions)
coeff = princomp(data);

for i = 1:nDimensions
    dimVec(i, :) = coeff(:, i);
end
end