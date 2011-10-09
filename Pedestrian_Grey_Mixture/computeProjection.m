function projData = computeProjection(data, meanData, dimVec)
nDimensions = size(dimVec, 1);

for i = 1:nDimensions
    projData(i) = dot(dimVec(i, :), data - meanData);
end
end