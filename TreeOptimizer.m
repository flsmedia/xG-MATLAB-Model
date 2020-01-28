function [bestTree, treeAccuracy] = TreeOptimizer(trainData, trainLabels, devData, devLabels)

tree1 = fitctree(trainData, trainLabels);

cvtree1 = crossval(tree1);

treeOutput = kfoldPredict(cvtree1);

TrainErr = sum(treeOutput~=trainLabels);
TrainErrRate = TrainErr / size(trainData, 1);

%using this loop to view eyeball all the trained trees, it was clear that
%the model "converged". all split on the same feature and had a depth of 2.

%test each tree on the dev data. use all features since CART's do selection

%test cross validated trees on separate development set to pick best one
treeErrList = [];
i = 1;
while i < 11
tempTreeOut = predict(cvtree1.Trained{i}, devData);
%view(cvtree1.Trained{i}, "Mode", "graph"); optional display
errors = sum(tempTreeOut ~= devLabels);
errRate = errors / size(trainData, 1);
treeErrList = [treeErrList; errRate];
i = i + 1;
end

%Find best model- one with lowest error in output list
[minimum, ind] = min(treeErrList);
bestTree = cvtree1.Trained{ind};
treeAccuracy = minimum;

end
