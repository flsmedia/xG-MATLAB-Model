%A Strapping young fello indeed'
function bootStrappedData = bootstrapping(Data)
[testDataLength, colSize] = size(Data);

bootStrappedData = zeros(testDataLength, colSize);
%test data seperation
for i = 1 : testDataLength
    randIndex = randi([1, testDataLength], 1, 1);
    
    bootStrappedData(i, :) = Data(randIndex, :);
end
end
