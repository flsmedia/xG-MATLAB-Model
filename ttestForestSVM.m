function [] = ttestForestSVM(resultsMatrix)

forest = resultsMatrix(:, 1) ;
SVM = resultsMatrix(:, 2);

[h1,p1] = ttest2(forest, SVM);


modelList =  ["forest", "SVM"];
varList = [var(forest), var(SVM)];
    
if ~any(h1)
    disp("both models' results come from the same distribution");
    
else
    if h1 == 1 %if we reject the null hypothesis 
        disp("Forest and SVM results are from separate distributions");
        disp("p value: " + p1);
        disp("Forest variance: " + var(forest) + "| SVM variance: " + var(SVM));
        disp(" ");
    end
end


i = 1;
    while i <= 2
        meanList(i) = mean(resultsMatrix(:, i));
        if meanList(i) == 0
            disp("--- " + modelList(i) + " 100% accurate ---");
            disp(" ");
        end
        i = i + 1;
    end
    
    disp("mean test error rate");
    disp(modelList + ": " + meanList);
    
    %if all models imperfect, compare variances
    if all(meanList) 
    [~, ind] = min(varList);
    disp(modelList(ind) + " has the lowest variance");
    end
    
end