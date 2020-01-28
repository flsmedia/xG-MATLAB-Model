function [errRate, prediction] = Perceive(data, labels, weights, b)

%predicts labels without adjusting, then checks accuracy at the end
%dotList = [];
prediction = zeros(size(data, 1), 1);

threshold = 0;
errors = 0;

feat1 = data(:, 1);
feat2 = data(:, 2);
feat3 = data(:, 3);
feat4 = data(:, 4);
feat5 = data(:, 5);
feat6 = data(:, 6);

i = 1;

while i <= size(feat1, 1)
    labelGuess = 0;
    
    dot = ( ( weights(1) * feat1(i) ) + ( weights(2) * feat2(i)) + (weights(3) * feat3(i)) + (weights(4) * feat4(i)) + (weights(5) * feat5(i)) + (weights(6) * feat6(i)) + b);
    
    if dot >= threshold
        labelGuess = 1; %perpceptron fires
    end
    
   % dotList = [dotList; dot];
    prediction(i) = labelGuess;
    
    if labelGuess ~= labels(i)
        errors = errors + 1;
    end
    i = i + 1;
    
end
%errors = sum(prediction ~= labels);
errRate = errors / size(data, 1);
%disp("development error: " + errRate + ". total errors: " + errors);
%disp(dotList);
end