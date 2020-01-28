disp("model 1: using raw data");
[weights1, b1] = optimizeSVM(short_unbal);

[errorRate1, test_pred] = Perceive(unbal_test, unbal_testLabels, weights1, b1);
disp("test error 1: " + errorRate1);
[xGoalErrors1t, harmonicMean1t, precision1t, recall1t] = getMetrics(test_pred, unbal_testLabels);
disp("HM: " + harmonicMean1t + "| Pre: " + precision1t + "| Rec: " + recall1t);
numGoalsGuessed1 = sum(test_pred);
numTrueGoals1 = sum(unbal_testLabels);
disp(" ");
disp("prediction / true goals");
disp(numGoalsGuessed1 + " / " + numTrueGoals1);
disp(" ");
disp("------------------- ");
disp(" ");

disp("model 2: using slightly rebalanced data");
[weights2, b2] = optimizeSVM(short_tilted);

[errorRate2, test_pred] = Perceive(unbal_test, unbal_testLabels, weights2, b2);
disp("test error 2: " + errorRate2);
[xGoalErrors2t, harmonicMean2t, precision2t, recall2t] = getMetrics(test_pred, unbal_testLabels);
disp("HM: " + harmonicMean2t + "| Pre: " + precision2t + "| Rec: " + recall2t);
numGoalsGuessed2 = sum(test_pred);
numTrueGoals2 = sum(unbal_testLabels);
disp(" ");
disp("prediction / true goals");
disp(numGoalsGuessed2 + " / " + numTrueGoals2);
disp(" ");
disp("----------------- ");
disp(" ");

disp("model 3: using undersampled fully balanced data");
[weights3, b3] = optimizeSVM(short_bal);

[errorRate3, test_pred] = Perceive(unbal_test, unbal_testLabels, weights3, b3);
disp("test error 3: " + errorRate3);
[xGoalErrors3t, harmonicMean3t, precision3t, recall3t] = getMetrics(test_pred, unbal_testLabels);
disp("HM: " + harmonicMean3t + "| Pre: " + precision3t + "| Rec: " + recall3t);
numGoalsGuessed3 = sum(test_pred);
numTrueGoals3 = sum(unbal_testLabels);
disp(" ");
disp("prediction / true goals");
disp(numGoalsGuessed3 + " / " + numTrueGoals3);

