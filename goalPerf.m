function [Performance] = goalPerf(dataTbl1) %dataTbl2)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
%--Oxy Soccer Team--%
    RealGoals = table2array(dataTbl1(:,"trueGoals"));
    aG = sum(RealGoals == 1);
    ExpGoals = table2array(dataTbl1(:,"xG"));
    xG = sum(ExpGoals == 1);
    A = table2array(dataTbl1(:,"ID"));
    B = unique(A);
    out = size(B,1);
    avgAG = (sum(aG)/out);
  
    avgXG = (sum(xG)/out);
 
 
    Performance = (aG - xG);
    avgPerformance = (avgAG - avgXG);
 
 
 disp("                                     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
 disp("                                     %     Actual Performance (aG) vs Expected Performance (xG)     %");
 disp("                                     %                      (2019-2020 Season)                      %");
 disp("                                     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
 disp("");
 disp(" ");
 disp("  --------------------------------");
 disp("  |   Overall Team Performance    |");
 disp("  |         (total goals)         |");
 disp("  -------------------------------");

 disp("    Total Goals: " +aG);
 if aG > xG
     disp(" Summary: The Oxy Men's Soccer team's season goal total was " + Performance+ " goal(s) above expectation; i.e. the team should have scored fewer goals from the shots  created.");
     disp(" Please refer to Figure 1 for a graphical representation.");
     
 elseif aG < xG
     disp(" Summary: The Oxy Men's Soccer team's season goal total was " + (-1*Performance) + " goal(s) below expectation; i.e. team should have scored more goals from the shots created.");
     disp(" Please refer to Figure 1 for a graphical representation.");

 else 
     disp(" Summary: The Oxy Men's Soccer team's season goal total was even with expectation, at "+aG+" goal(s); i.e. the team scored as many goals as it should have.");
     disp(" Please refer to Figure 1 for a graphical representation.");
 end
 
 figure(1);
        Y = [aG xG];
        X = categorical({'Actual Goal Outcome (aG)', 'Expected Goal Outcome (xG)'});
        X = reordercats(X,{'Actual Goal Outcome (aG)', 'Expected Goal Outcome (xG)'});
        B = bar(X, Y, 'stacked');
        B.FaceColor = 'flat';
        B.CData(2,:) = [1,0,0];
        title({'Overall Team Performance (2019-2020 Season)'; '(total goals scored against expectation)'});
        if aG < xG
            xlabel("The team's goal total was " + (-1*Performance)+ " goal(s) below expectation");
        elseif aG > xG
            xlabel("The team's goal total was " + Performance+ " goal(s) above expectation");
        elseif aG == xG
            xlabel("The team's goal total was even with expectation, at " + aG+ " goal(s).");
        end
        
 disp(" ");
 disp("  ---------------------------------");
 disp("  |   Team Performance per Game   |");
 disp("  |    ( average no. of goals)    |");
 disp("  ---------------------------------"); 
 
 if aG > xG
    disp("    Summary: The team averaged " + round(avgAG,2) + " goals per game, scoring about " + round(avgPerformance,2) + " goal(s) above expectation.");
    disp("    Conclusion: on average, the team overperformed xG, suggesting that this season's goals per game should have been lower, and is thus a relatively");
    disp("                inaccurate representation of the team's offensive prowess. It's likely that said overachievement is buoyed by a few lop-sided victories."); 
    disp("    Please refer to Figure 2 for a graphical representation.");

 elseif aG < xG
    disp("    Summary: The team averaged " + round(avgAG,2) + " goals per game, scoring about " + (-1*(round(avgPerformance,2))) + " goal(s) below expectation.");
    disp("    Conclusion: on average, the team underperformed xG, suggesting that this season's goals per game should have been higher, and that the team has yet");
    disp("                to reach its offensive peak.");
    disp("    Please refer to Figure 2 for a graphical representation.");

 else
    disp("    Summary: The team averaged " + round(avgAG,2) + " goals per game, even with expectation.");
    disp("    Conclusion: on average, the team performed on par with xG, suggesting that this season's goals per game is a reasonably accurate representation of the team's offensive prowess.");
    disp("    Please refer to Figure 2 for a graphical representation.");
 end
 
 figure(2);
        Y = [avgAG avgXG];
        X = categorical({'Average Goals Scored per Game (avgAG)', 'Expected Goals Scored per Game (avgXG)'});
        X = reordercats(X,{'Average Goals Scored per Game (avgAG)', 'Expected Goals Scored per Game (avgXG)'});
        B = bar(X, Y, 'stacked');
        B.FaceColor = 'flat';
        B.CData(2,:) = [1,0,0];
        title({'Team Performance per Game (2019-2020 Season)'; '(average no. of goals)'});
        if aG < xG
            xlabel("The team averaged " + round(avgAG,2)+ " goals per game, about "+(-1*(round(avgPerformance,2)))+" goal(s) below expectation");
        elseif aG > xG
            xlabel("The team averaged " + round(avgAG,2)+ " goals per game, about "+round(avgPerformance,2)+" goal(s) above expectation");
        elseif aG == xG
            xlabel("The team's per game average is even with expectation at " + round(avgAG,2)+ " goals per game.");
        end
