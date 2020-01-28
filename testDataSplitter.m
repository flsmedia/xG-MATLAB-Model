%{This function divides a data set into a training set and a test set
% It takes in a matrix of data and a whole number 0 - 100 that specifies what
% percentage of the data to split into a test set. It outputs a training
% and a test data set}
function[trainingData, testData] = testDataSplitter(Data, TestDataPercent)
%get the number of rows and columns from the incomming data set
[rawDataRowNum, rawDataColumnNum] = size(Data);
%this calculates how many rows should be in the test set based on the
%percent imputed and the amount of rows in the OG data set
numTestRows = round(rawDataRowNum * (TestDataPercent / 100));
%creates a matrix that is the same column size and has the correct
%percentage of rows
trainingData = Data;
% indexes through the testData matrix, replacing each row of zeroes with a
% row from the OG data set,  then removes that row from the OG data set
rowIndex = 1;
while rowIndex < numTestRows
    %gets a random index for the OG data
    randomIndex = randi(rawDataRowNum);
    testData(rowIndex, :) = trainingData(randomIndex, :);
    trainingData(randomIndex, :) = [];
    rawDataRowNum = rawDataRowNum - 1;
    
    rowIndex = rowIndex + 1;
end
