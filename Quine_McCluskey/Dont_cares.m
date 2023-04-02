%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Half_Vdd] = Dont_cares(Truth_table, Half_Vdd)
    for i = 1:length(Truth_table(:,1))
        if ((Truth_table(i,1) == 1) || (Truth_table(i,2) == 1)) && (Half_Vdd(i,1) == "X")
            Half_Vdd(i,1) = "OFF";
        elseif ((Truth_table(i,1) == 1) || (Truth_table(i,2) == 1)) && (Half_Vdd(i,2) == "X")
            Half_Vdd(i,2) = "OFF";
        elseif (Half_Vdd(i,1) == "X")
            Half_Vdd(i,1) = "ON";
        elseif (Half_Vdd(i,2) == "X")
            Half_Vdd(i,2) = "ON";
        end
    end
end