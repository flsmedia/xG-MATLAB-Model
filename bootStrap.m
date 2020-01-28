function [accuracies] = bootStrap(forest, weights, b, allFeatsTest, labels)

accuracies = zeros(20, 2);
sz = size(allFeatsTest, 1);
t = 1;
while t <= 20
bootsAllFeats = zeros(sz, 6);
bootsLabels = zeros(sz, 1);

    %use test set to generate randomized new test set
    i = 1;
    while i <= sz
        rand = randi(sz);
        bootsAllFeats(i, :) = allFeatsTest(rand, :);
        bootsLabels(i) = labels(rand); 
        i = i + 1;
    end
    
        %predict all models
        forestOut = predict(forest, bootsAllFeats);
        forestOut = str2double(forestOut);
        accuracies(t, 1) = ( sum(forestOut(:, 1)~=bootsLabels) / sz );
     
        accuracies(t, 2) = Perceive(bootsAllFeats, bootsLabels, weights, b);
   
t = t + 1;
end

end