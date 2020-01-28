function [balancedSet] = balanceData(data_wLabels)

dataLength = size(data_wLabels, 1);
dataWidth = size(data_wLabels, 2);
balancedSet = [];

labels = data_wLabels(:, dataWidth);

last_label = 1;
i = 1;
while i < dataLength
    cur_label = labels(i);
    
    if cur_label ~= last_label
        balancedSet = [balancedSet; data_wLabels(i, :)]; 
        last_label = cur_label; %store this label value to compare to next one
    elseif mod(i, 3) == 0
        balancedSet = [balancedSet; data_wLabels(i, :)]; 
    end
    
    i = i + 1;
end

end