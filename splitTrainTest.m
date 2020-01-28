function [training, testing] = splitTrainTest(dataSet , P)
% https://www.mathworks.com/matlabcentral/answers/395136-how-to-divide-a
%-data-set-randomly-into-training-and-testing-data-set
[m,~] = size(dataSet);
idx = randperm(m);
training = dataSet(idx(1:round(P*m)),:); 
testing = dataSet(idx(round(P*m)+1:end),:);

end
