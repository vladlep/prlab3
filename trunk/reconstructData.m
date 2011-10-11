function reconstData = reconstructData(meanData, projData, dimVec)
reconstData = meanData;
nDimensions = size(dimVec, 1);

for i = 1:nDimensions
    reconstData = reconstData + projData(i) * dimVec(i, :);
end
end