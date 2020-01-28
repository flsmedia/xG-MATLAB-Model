function [weights, b, classError] = EstablishPerceptron(data, labels, weights, b, max, maxError)

% max is an int that determines how long alg iterates before deciding it
% won't converge and accepting a nonzero error rate

feat1 = data(:, 1);
feat2 = data(:, 2);
feat3 = data(:, 3);
feat4 = data(:, 4);
feat5 = data(:, 5);
feat6 = data(:, 6);

threshold = 0;

iterator = 0; %counts how long alg has looped
classError = 1; %assumes model not yet perfect

while classError > 0
    
errCount = zeros(1, size(feat1, 1));
i = 1;
while i <= size(feat1, 1)
    labelGuess = 0;

    dot = ( ( weights(1) * feat1(i) ) + ( weights(2) * feat2(i)) + (weights(3) * feat3(i)) + (weights(4) * feat4(i)) + (weights(5) * feat5(i)) + (weights(6) * feat6(i)) + b) ; %dot product
    %disp(dot);
    if dot > threshold
        labelGuess = 1; %perpceptron fires
    end
            %if labeled correctly, keep loopin
    if labelGuess == labels(i)
        i = i + 1; %only proceed to next data point once this one is identified
    else
        %if incorrect, adjust the weights and re-loop on same data point
        %don't increment i
        [weights, b] = AdjustWeight(weights, feat1(i), feat2(i), feat3(i), feat4(i), feat5(i), feat6(i), b, labels(i));
        errCount(i) = 1;
        
    end
    
end

classError = sum(errCount);
iterator = iterator + 1;


if iterator > max/2 
    
    if (classError / size(feat1, 1)) < maxError
        classError = classError / size(feat1, 1);
        %disp("nearly converged- " + iterator + " iterations");
        %disp("Training error: " + classError);
        
        return 
        
    elseif iterator >= max
        classError = classError / size(feat1, 1);
        %disp("Not linearly separable- " + iterator + " iterations");
        %disp("Training error: " + classError);
        
        return 
    end
end

end

%disp("converged " + iterator + " iterations");
%disp("Training error: " + classError);

return %if training error hits zero

end
    





