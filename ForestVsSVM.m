clc
load soccer_workspace.mat

%------build & optimize models-------
%this splits data, establishes SVM and cross validates to find best weights
%svm was also optimized by hand by testing balanced and unbalanced datasets
[weights, b, error_unbal] = optimizeSVM(short_unbal);

%this takes too long to run, so output model is already in the workspace. 
%optimizedRandomForest = RandomForestOptimizer(1000, 250, 100);

%------test models-----------------
[accuracies] = bootStrap(finalForest, weights, b, unbal_test, unbal_testLabels)
disp("finalForest");
disp(finalForest);
ttestForestSVM(accuracies);

forestOut = predict(finalForest, unbal_test);
forestOut = str2double(forestOut);
disp(" ");
disp("---Forest Accuracy Metrics---");
[xGoalErrors1, harmonicMean, precision, recall, forestxG, aG] = getMetrics(forestOut, unbal_testLabels);
disp("HM: " + harmonicMean + "| Pre: " + precision + "| Rec: " + recall);
disp("number off from true goals: " + xGoalErrors1);
disp(" ");

disp("---SVM Accuracy Metrics---");
[~, svmOut] = Perceive(unbal_test, unbal_testLabels, weights, b);
[xGoalErrors2, harmonicMean2, precision2, recall2, SVMxG, aG] = getMetrics(svmOut, unbal_testLabels);
disp("HM: " + harmonicMean2 + "| Pre: " + precision2 + "| Rec: " + recall2);
disp("number off from true goals: " + xGoalErrors2);

disp(" ");

difference = abs(xGoalErrors1 - xGoalErrors2);
if xGoalErrors1 < xGoalErrors2
    disp("The random forest performed better at predicting xG by " + difference + " goals.");

elseif xGoalErrors1 > xGoalErrors2
    disp("The support vector machine performed better at predicting xG by " + difference + " goals.");
else
    disp("The models performed equally well at predicting number of goals");
end


disp("                 ------Actual Goals (aG) vs Expected Goals (xG)------            ");
performance = table(forestxG, aG);
disp(performance);