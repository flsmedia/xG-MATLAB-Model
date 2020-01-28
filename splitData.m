function [trainData, trainLabels, testData, testLabels, devData, devLabels] = splitData(dataMatrix, labelList)

%generates dev and test set with around 1/5 number elements as training set

trainData = dataMatrix; %don't mess up the original data
tempLabels = labelList;

devData = [];
sz = size(trainData, 1);
devSize = round(sz / 5);

devLabels = [];
testLabels = [];

i = 1;

while i <= devSize
    
rand = randi(sz);
devData = [devData; trainData(rand, :)];
trainData(rand, :) = [];
devLabels = [devLabels; tempLabels(rand)];
tempLabels(rand) = [];


%reduce rand scope by 1 and increment
sz = sz - 1;
i = i + 1;
end

%--------------------------------------------------

testData = [];
sz = size(trainData, 1);
testSize = size(devData, 1);

i = 1;

while i <= testSize
    
rand = randi(sz);
testData = [testData; trainData(rand, :)];
trainData(rand, :) = [];
testLabels = [testLabels; tempLabels(rand)];
tempLabels(rand) = [];

%reduce rand scope by 1 and increment
sz = sz - 1;
i = i + 1;
end

trainLabels = tempLabels;
    
end



