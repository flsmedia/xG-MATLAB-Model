function optimizedRandomForest = RandomForestOptimizer(dataLength, MaxNumTrees, MaxSplits)
%{
-- Data Importing & Processing --

The data has already been cleaned of non-viable data points (data points
lacking the necessary feature values). What was left was to convert the
data from the oxy soccer team into the same format. 
There are three version of the european data set. one is a completely balanced dataset (via undersampling). The
other has been shifted (via undersampling) to be less biased (% of shots
that are goals increased to 25% from 10). The last is the raw, unbalanced
data.
%}
load('soccer_workspace.mat');

balanced_dataset(:, 1) = [];
balanced_dataset = balanced_dataset(1:dataLength, :);
dataNoNans(:, 1) = [];
dataNoNans = dataNoNans(1:(dataLength + (dataLength / 4)), :); %extra here for testing
tilted_dataset(:, 1) = [];
tilted_dataset = tilted_dataset(1:dataLength, :);

clear labels bal_labels bal_feats longData

%{
-- Data Seperation --
Here data is divided into training and test sets. For the balanced data
sets only the training set matters as we will be using unbalanced data for
the testing.
%}
[trainingDataUnprocessed, devDataUnprocessed] = testDataSplitter(dataNoNans, 20);

%{
-- Model Training --
Here the random forest are trained. This will be to selected the best data
set for training. With the data selected, the next step will be to optimize
the model for num trees, feature selection, ect.
%}
randomForestBalanced = TreeBagger(25, balanced_dataset(:, 1:end-1), balanced_dataset(:, end));
randomForestTilted = TreeBagger(25, tilted_dataset(:, 1:end-1), tilted_dataset(:, end));
randomForestUnprocessed = TreeBagger(25, trainingDataUnprocessed(:, 1:end-1), trainingDataUnprocessed(:, end));

%{
-- Model Testing 1: which training data set produces the most accurate
results-- 
This model comparison will test each of the trained models on a number of
bootstrapped version of the unprocessed test set. The model that performs
the best will be chosen for further optimization
%}
errorRatesBM = zeros(10, 1);
errorRatesTM = zeros(10, 1);
errorRatesUPM = zeros(10, 1);

for testNumber = 1 : 9
    testSet = bootstrapping(devDataUnprocessed);
    %balanced Model
    tempBMPredictions = predict(randomForestBalanced, testSet(:, 1:end -1));
    errorRatesBM(testNumber) = sum(str2double(tempBMPredictions) ~= testSet(:, end)) / size(testSet, 1);
    %Tilted Model
    tempTMPredictions = predict(randomForestTilted, testSet(:, 1:end -1));
    errorRatesTM(testNumber) = sum(str2double(tempTMPredictions) ~= testSet(:, end)) / size(testSet, 1);
    %Unprocessed Model
    tempUPMPredictions = predict(randomForestUnprocessed, testSet(:, 1:end -1));
    errorRatesUPM(testNumber) = sum(str2double(tempUPMPredictions) ~= testSet(:, end)) / size(testSet, 1);
end
tempBMPredictions = predict(randomForestBalanced, devDataUnprocessed(:, 1:end -1));
errorRatesBM(end) = sum(str2double(tempBMPredictions) ~= devDataUnprocessed(:, end)) / size(devDataUnprocessed, 1);

tempTMPredictions = predict(randomForestTilted, devDataUnprocessed(:, 1:end -1));
errorRatesTM(end) = sum(str2double(tempTMPredictions) ~= devDataUnprocessed(:, end)) / size(devDataUnprocessed, 1);

tempUPMPredictions = predict(randomForestUnprocessed, devDataUnprocessed(:, 1:end -1));
errorRatesUPM(end) = sum(str2double(tempUPMPredictions) ~= devDataUnprocessed(:, end)) / size(devDataUnprocessed, 1);

if ttest(errorRatesBM, errorRatesTM) == 1
    disp(1);
    if var(errorRatesBM) < var(errorRatesTM)
        disp(2);
        if ttest(errorRatesBM, errorRatesUPM) == 1
            disp(3);
            if var(errorRatesUPM) < var(errorRatesBM)
                disp(4);
                clear balanced_dataset tilted_dataset
            else
                disp(5);
                clear trainingDataUnprocessed devDataUnprocessed dataNoNans tilted_dataset
            end
        else
            disp(6);
            if mean(errorRatesUPM) < mean(errorRatesBM)
                disp(7);
                clear balanced_dataset tilted_dataset
            else
                diso(8);
                clear trainingDataUnprocessed devDataUnprocessed dataNoNans tilted_dataset
            end
        end
    else
        disp(9);
        if ttest(errorRatesTM, errorRatesUPM) == 1
            disp(10);
            if var(errorRatesUPM) < var(errorRatesTM)
                disp(11);
                clear balanced_dataset tilted_dataset
            else
                disp(12);
                clear trainingDataUnprocessed devDataUnprocessed dataNoNans balanced_dataset
            end
        else
            disp(13);
            if mean(errorRatesUPM) < mean(errorRatesTM)
                disp(14);
                clear balanced_dataset tilted_dataset
            else
                disp(15);
                clear trainingDataUnprocessed devDataUnprocessed dataNoNans balanced_dataset
            end
        end
    end 
else
    disp(16);
    if var(errorRatesBM) < var(errorRatesTM)
        disp(17);
        if ttest(errorRatesBM, errorRatesUPM) == 1
            disp(18);
            if var(errorRatesUPM) < var(errorRatesBM)
                disp(19);
                clear balanced_dataset tilted_dataset
            else
                disp(20);
                clear trainingDataUnprocessed devDataUnprocessed dataNoNans tilted_dataset
            end
        else
            disp(21);
            if mean(errorRatesUPM) < mean(errorRatesBM)
                disp(22);
                clear balanced_dataset tilted_dataset
            else
                disp(23);
                clear trainingDataUnprocessed devDataUnprocessed dataNoNans tilted_dataset
            end
        end
    else
        disp(24);
       if ttest(errorRatesTM, errorRatesUPM) == 1
           disp(25);
            if var(errorRatesUPM) < var(errorRatesTM)
                disp(26);
                clear balanced_dataset tilted_dataset
            else
                disp(27);
                clear trainingDataUnprocessed devDataUnprocessed dataNoNans balanced_dataset
            end
       else
            disp(28);
            if mean(errorRatesUPM) < mean(errorRatesTM)
                disp(29);
                clear balanced_dataset tilted_dataset
            else
                disp(30);
                clear trainingDataUnprocessed devDataUnprocessed dataNoNans balanced_dataset
            end
        end
    end
end
clear testNumber testSet tempTMPredictions tempBMPredictions tempUPMPredictions devDataUnprocessed trainingDataUnprocessed errorRatesBM errorRatesTM errorRatesUPM

if exist('tilted_dataset') == 1
    optimalDataSet = tilted_dataset;
    clear tilted_dataset
elseif exist('balanced_dataset') == 1
    optimalDataSet = balanced_dataset;
    clear balanced_dataset
elseif exist('dataNoNans') == 1
    optimalDataSet = dataNoNans;
    clear dataNoNans
end
 
[trainingData, testData] = testDataSplitter(optimalDataSet, 20);

clear randomForestUnprocessed randomForestBalanced randomForestTilted optimalDataSet
%{
-- Parameter Selection --
this section continue with the optimal dataset found through the last round
of testing. CrossValidation will be performed to identify which is the
best value for the parameters:
Num Trees
%}

%NumTrees optimization
optimalNumTrees = 1;
optimalModelErrorRates = zeros(60, 1);
comparisonModelErrorRates = zeros(60, 1);
currentNumTrees = 10;
while currentNumTrees <= MaxNumTrees
    index = 1;
    for modelItteration = 1 : 20
        [trainingSet, devSet] = testDataSplitter(trainingData, 20);
        tempForest = TreeBagger(currentNumTrees, trainingSet(:, 1:end-1), trainingSet(:, end));
        for boostrappedTest = 1 : 3
            devSet = bootstrapping(devSet);
            tempPredictions = predict(tempForest, devSet(:, 1:end -1));
            comparisonModelErrorRates(index) = (sum(str2double(tempPredictions) ~= devSet(:, end)) / size(devSet, 1));
            index = index + 1;
        end
    end
    if mean(optimalModelErrorRates) == 0
        optimalModelErrorRates = comparisonModelErrorRates;
        optimalNumTrees = currentNumTrees;
    elseif ttest(optimalModelErrorRates, comparisonModelErrorRates) == 1
        if var(comparisonModelErrorRates) < var(optimalModelErrorRates)
            optimalModelErrorRates = comparisonModelErrorRates;
            optimalNumTrees = currentNumTrees;          
        end
    else
        if mean(comparisonModelErrorRates) < mean(optimalModelErrorRates)
            optimalModelErrorRates = comparisonModelErrorRates;
        end
    end
    currentNumTrees = currentNumTrees + 10;
end

%Tree depth optimization
currentTreeDepth = 1;
optimalTreeDepth = 0;
while currentTreeDepth <= MaxSplits
    index = 1;
    for modelItteration = 1 : 20
        [trainingSet, devSet] = testDataSplitter(trainingData, 20);
        tempForest = TreeBagger(optimalNumTrees, trainingSet(:, 1:end-1), trainingSet(:, end), 'Method', 'classification', 'MaxNumSplits', currentTreeDepth);
        for boostrappedTest = 1 : 3
            devSet = bootstrapping(devSet);
            tempPredictions = predict(tempForest, devSet(:, 1:end -1));
            comparisonModelErrorRates(index) = (sum(str2double(tempPredictions) ~= devSet(:, end)) / size(devSet, 1));
            index = index + 1;
        end
    end
    if ttest(optimalModelErrorRates, comparisonModelErrorRates) == 1
        if var(comparisonModelErrorRates) < var(optimalModelErrorRates)
            optimalModelErrorRates = comparisonModelErrorRates;
            optimalTreeDepth = currentTreeDepth;          
        end
    else
        if mean(comparisonModelErrorRates) < mean(optimalModelErrorRates)
            optimalModelErrorRates = comparisonModelErrorRates;
            optimalTreeDepth = currentTreeDepth;
        end
    end
    currentTreeDepth = currentTreeDepth + 1;
end

if optimalTreeDepth == 0
    optimizedRandomForest = TreeBagger(optimalTreeDepth, trainingData(:, end-1), trainingData(:, end));
else
    optimizedRandomForest = TreeBagger(optimalNumTrees, trainingSet(:, 1:end-1), trainingSet(:, end), 'Method', 'classification', 'MaxNumSplits', optimalTreeDepth);
end