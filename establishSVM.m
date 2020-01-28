function [adj_weights, adj_b, avg_gradient, iterations] = establishSVM(weights, b, data, labels, c)

%Malvika and Logan helped me write this

sz = size(data, 1);
numWeights = size(weights, 2);

adj_weights = weights;
old_weight = 0;
adj_b = b;

gradient = [1,1,1,1,1,1];
avg_gradient = 99999;
iterations = 0;

while abs(avg_gradient) > 0.0000000000001 && iterations < 100
    
    for i = 1:sz
        for w = 1:numWeights
            
            old_weight = adj_weights(w);
            
            maximum = max(0,  -(labels(i)));
            step = -2 * adj_weights(w) + (c * maximum * data(i, w));
            adj_weights(w) = adj_weights(w) + step/10000;
            
            gradient(w) = old_weight - adj_weights(w); %calculate weight changes
            
        end
    
        adj_b = adj_b + ( -c * (max(0, -(labels(i)) ) ));
        
        avg_gradient = mean(gradient); %average change in weight for this datapoint
    end

    iterations = iterations + 1;
end

end