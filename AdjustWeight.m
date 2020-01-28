function[newWeights, new_b] = AdjustWeight(weights, feat1i, feat2i, feat3i, feat4i, feat5i, feat6i, b, trueLabel)

adjustedLabel = 1;
if trueLabel == 0
    adjustedLabel = -1; %if it's fake, multiply by -1
end

newWeights = [];

newWeights(1) = weights(1) + ((feat1i * adjustedLabel) * .0001);
newWeights(2) = weights(2) + ((feat2i * adjustedLabel) *.0001);
newWeights(3) = weights(3) + ((feat3i * adjustedLabel) *.0001);
newWeights(4) = weights(4) + ((feat4i * adjustedLabel) *.0001);
newWeights(5) = weights(5) + ((feat5i * adjustedLabel) *.0001);
newWeights(6) = weights(6) + ((feat6i * adjustedLabel) *.0001);
new_b = b + (adjustedLabel);

%called in TrainPerceptron with each incorrect data hit
%takes in current weight vector and the last dot product for reference
%returns adjusted weights 
end