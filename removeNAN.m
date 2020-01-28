function [newData, newlabels] = removeNAN(data, labels)

newData = [];
newlabels = [];

numFeats = size(data, 2);
datapoint = zeros(1, numFeats);

sz = size(data, 1);
for i = 1:sz
    
     for col = 1:numFeats
        
     datapoint(col) = isnan( data(i, col) );
     end
            if ~any(datapoint) % if this feat for this entry is N/A
                 newData = [newData; data(i, :)]; %delete entry
                 newlabels = [newlabels; labels(i)];
            end
                 
end


end
