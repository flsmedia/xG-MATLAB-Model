labels = longData(:, 8);
feats = longData(:, 1:7);

[newfeats, newLabels] = removeNAN(feats,labels);
dataNoNans = newfeats;
dataNoNans(:, 8) = newLabels;

dataset = balanceData(dataNoNans);

