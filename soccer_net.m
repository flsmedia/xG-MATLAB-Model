
net = feedforwardnet(10);
net = configure(net, tiltedFeats, tiltedLabels);
net = train(net, tiltedFeats, tiltedLabels);

x_goals = net(unbal_shortfeats)
%prediction = perform(net, unbal_shortfeats, unbal_shortlabels)
