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
disp("finalForest (Random Forest Model)");
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
    disp("Conclusion: the Random Forest performed better at predicting xG by " + difference + " goals.");
    disp("            Thus we will use this model for our predictions and analysis going forward.");

elseif xGoalErrors1 > xGoalErrors2
    disp("Conclusion: the Support Vector Machine performed better at predicting xG by " + difference + " goals.");
    disp("            Thus we will use this model for our predictions and analysis going forward.");

else
    disp("Conclusion: both models performed equally well at predicting expected number of goals");
    disp("            Thus we will use this model for our predictions and analysis going forward.");

end
disp("                             --------------------------------------------------------------------------------                             ");
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%|TEST RANDOM FOREST MODEL ON OXY SOCCER DATASET FOR EXPECTED GOALS (xG) ANALYSIS|%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
disp("                             --------------------------------------------------------------------------------                             ");

%Import the Oxy shot data as a table
oxyshotdata;

time = (oxyshotdata(:,"Time"));
side = (oxyshotdata(:,"Side"));
shot_place = (oxyshotdata(:,"Shot_place"));
shot_outcome = (oxyshotdata(:,"Shot_outcome"));
is_goal = oxyshotdata(:,"is_goal");
location = oxyshotdata(:,"Location");
bodypart = oxyshotdata(:,"Body_Part");
assist_method = oxyshotdata(:,"assist_method");
situation = oxyshotdata(:,"Situation");
fast_break = oxyshotdata(:,"FastBreak");
team = oxyshotdata(:,"Event_team");
player = oxyshotdata(:,"Player");
ID = oxyshotdata(:,"ID");

OxyData = [ID team player side shot_place location bodypart assist_method situation fast_break is_goal];
goalPredictions = predict(finalForest, OxyData{:, 5:end-1});

[OxyShots] = Organize(goalPredictions, OxyData);

goalPerf(OxyShots);
disp(" ");
disp(" ");
disp("                                     -----------------------------------------------------------------               ");
disp("                                     |         Individual Match Analysis (2019-2020 Season)          |               ");
disp("                                     -----------------------------------------------------------------               ");
disp(" ");
[firstColumn] = gamePerf(OxyShots);    
  