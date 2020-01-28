function [bestWeights, bestB, PerceptronAccuracyList] = CrossVal(trainData, labels, devData, devLabels, inputWeights, inputB, iterations, threshold)

PerceptronAccuracyList = [];
lowestErr = 1; %placeholder for comparison
i = 1;
while i < (size(trainData, 1) - 81)
    j = i + 80;
    %reset temps to full dataset
    tempdata = trainData;
    templabels = labels;
    
    %establish development chunk
    dataChunk = trainData(i:j, :);
    labelChunk = labels(i:j, :);
    
    %remove dev chunk from temp data set
    tempdata(i:j, :) = [];
    templabels(i:j, :) = [];
    
    %train on temp data set
    [weights, b] = EstablishPerceptron(tempdata, templabels, inputWeights, inputB, iterations, threshold);
    [adj_weights, adj_b] = establishSVM(weights, b, trainData, labels, 1);
    %test on dev chunk
    [perceptOut] = Perceive(devData, devLabels, adj_weights, adj_b);
    %{
    disp("Perceive development error: " + perceptOut);
    disp("^ weights"); disp(weights);
    disp("^ bias " + b);
    disp("-------------------------------------");
    %}
    if perceptOut < lowestErr
        lowestErr = perceptOut;
        bestWeights = weights;
        bestB = b;
    end
   
    PerceptronAccuracyList = [PerceptronAccuracyList; perceptOut];
    i = i + 81;
  
end

end