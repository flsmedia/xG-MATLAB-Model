function [OxyShots] = Organize(array,dataSet)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
xG = str2double(array);
truegoals = dataSet(:, "is_goal");
trueGoals = table2array(truegoals);
difference = [xG-trueGoals];
team = table2array(dataSet(:,"Event_team"));
player = table2array(dataSet(:,"Player"));
ID = dataSet(:,"ID");
Player = [team player];

for i =1:size(Player,1)
        if Player(i)== "Occidental"
            Player(i) = "1";
        else
            Player(i) = "0";
        end
       
end

Team = Player(:,1);
Team = table(Team);

Player = Player(:,2);
Player = table(Player);

trueGoals = table(trueGoals);

xG = table(xG);

difference = table(difference);
OxyShots = [ID Team Player trueGoals xG difference];


OxyShots = sortrows(OxyShots, "Team");
%disp("OXY SHOTS");
%disp(OxyShots);
%gameData = OxyShots;

T = (OxyShots(:,"Team"));
P = (OxyShots(:,"Player"));
tG = (OxyShots(:,"trueGoals"));
XG = (OxyShots(:,"xG"));
Diff = (OxyShots(:,"difference"));
ID = (OxyShots(:,"ID"));
Cat = [T P];
Quant = [T tG XG Diff ID];

% Quant(Quant.Team == "0", :) = [];
% 
% Cat(Cat.Team == "0", :) = [];
T = Cat(:,1);
P = Cat(:,2);
tG = Quant(:,2);
XG = Quant(:,3);
Diff = Quant(:,4);
ID = Quant(:,5);
OxyShots = [T P tG XG Diff ID];
%size(OxyShots, 1)
end

