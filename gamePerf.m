function [lastColumn] = gamePerf(dataTbl)
%   This function performs xG analysis on each recorded game (16 total),
%   by splitting up the shot data based on its game ID (e.g. all events 
%   from the fourth game have an ID of 4).
%
lastColumn = table2array(dataTbl(:, end));
%disp(lastColumn);
Team = table2array(dataTbl(:,1));


 
for i = 1:max(lastColumn)

         OxyGoals = dataTbl(lastColumn == i, :);
         OppGoals = dataTbl(lastColumn == i, :);
         
            OxyGoals(OxyGoals.Team == "0", :) = [];
            OppGoals(OppGoals.Team == "1", :) = [];
          
            RG = table2array(OxyGoals(:,"trueGoals"));
            aG = sum(RG == 1);
            XG = table2array(OxyGoals(:,"xG"));
            xG = sum(XG == 1);

            OppRG = table2array(OppGoals(:,"trueGoals"));
            OppAG = sum(OppRG == 1);
            ExG = table2array(OppGoals(:,"xG"));
            OppXG = sum(ExG == 1);
            XPerformance = (xG - OppXG);
            APerformance = (aG - OppAG);
            disp(" ");
            disp("      Game " + i);
            
            
            if aG > OppAG 
                disp("----Oxy Victory----");
                disp("Actual Score: " +aG+"-"+OppAG);
                disp("Expected Score: " + xG +"-"+OppXG);
                if xG >OppXG
                    disp("Game Summary: Oxy was expected to win by " + XPerformance+ " goal(s), and ultimately won by "+APerformance+".");
                elseif xG < OppXG
                    disp("Game Summary: though Oxy was expected to lose by " + (-1*XPerformance) + " goal(s), the team ultimately won by " +APerformance+".");
                else
                    disp("Game Summary: though Oxy was expected to draw this match, the team ultimately won by " + APerformance + " goal(s).");
                end
            elseif aG < OppAG    
                disp("----Oxy Defeat----");
                disp("Actual Score: " +aG+"-"+OppAG);
                disp("Expected Score: " + xG +"-"+OppXG);
                    if xG >OppXG
                        disp("Game Summary: though Oxy was expected to win by " + XPerformance+ " goal(s), the Tigers ultimately lost by "+(-1*APerformance)+".");
                    elseif xG < OppXG
                        disp("Game Summary: Oxy was expected to lose by " + (-1*XPerformance) + " goal(s), and ultimately lost by "+(-1*APerformance)+".");
                    else
                        disp("Game Summary: though Oxy was expected to draw this match, the Tigers ultimately lost by "+(-1*APerformance)+" goal(s).");
                    end
                
            else
                disp("----Draw (Tie)----");
                disp("Actual Score: " +aG+"-"+OppAG);
                disp("Expected Score: " + xG +"-"+OppXG);
                    if xG >OppXG
                        disp("Game Summary: though Oxy was expected to win by " + XPerformance+ " goal(s), the Tigers ultimately drew with their opponent.");
                    elseif xG < OppXG
                        disp("Game Summary: though Oxy was expected to lose by " + (-1*XPerformance) + " goal(s), the Tigers ultimately drew with their opponent.");
                    else
                        disp("Game Summary: Oxy was expected to draw this match, and ultimately did so.");
                    end
            end
end