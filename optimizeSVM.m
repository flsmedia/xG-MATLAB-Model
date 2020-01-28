%split into features and y values, remove irrelevant data (rows with NAN values) 
%then split data into training, test, development sets
function [bestWeights, bestB, error, predictions, testLabels] = optimizeSVM(data)

labels = data(:, 7);
data(:, 7) = [];


[trainData, trainLabels, testData, testLabels, devData, devLabels] = splitData(data, labels);

%%-------------------------------
%train perceptron, then adjust into soft margin SVM using gradient descent,
%then cross validate, test best model

startingWeights = [0,0,0,0,0,0];
startingB = 0;
[weights, b] = EstablishPerceptron(trainData, trainLabels, startingWeights, startingB, 100, .15);

[adj_weights, adj_b] = establishSVM(weights, b, trainData, trainLabels, 1);

[bestWeights, bestB, svmAccuracies] = CrossVal(trainData, trainLabels, devData, devLabels, adj_weights, adj_b, 100, .15);

%disp("SVM cross val accuracies: ");
%disp(svmAccuracies);

[error, predictions] = Perceive(testData, testLabels, bestWeights, bestB);
%disp("f* classification error rate for SVM: " + error);
%disp(" ");


end




