function [xGoalErrors, harmonicMean, precision, recall, GoalsGuessed, TrueGoals] = getMetrics(predictions, labels)
truePositive = 0;
falsePositive = 0;
falseNegative = 0;
trueNegative = 0;
i = 1;
while i <= size(predictions, 1)
    if predictions(i) == 1 
        if labels(i) == 1
            truePositive = truePositive + 1;
        else
            falsePositive = falsePositive + 1;
        end
    else %if predicted 0 - a missed shot
        if labels(i) == 1
            falseNegative = falseNegative + 1;
        else
            trueNegative = trueNegative + 1;
        end
    
    end
i = i + 1;
end
%{
disp("correctly guessed goals: " + truePositive);
disp("correctly guessed misses: " + trueNegative);
disp("false positive goals: " + falsePositive);
disp("true goals that weren't guessed: " + falseNegative);
disp(" ");
%}

precision = truePositive / (truePositive + falsePositive);
recall = truePositive / sum(labels);
if precision == 0 && recall == 0
    harmonicMean = 0;
else
    harmonicMean = (2 * precision * recall) / precision + recall;
end
classificationError = sum(predictions~=labels);

GoalsGuessed = sum(predictions);
TrueGoals = sum(labels);
disp("prediction / true goals : " + GoalsGuessed + " / " + TrueGoals);

xGoalErrors = abs(GoalsGuessed - TrueGoals);

end