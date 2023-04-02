%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Vdd_GND, Half_Vdd] = Generate_pull_up_down_tables(Truth_table)
    for i = 1:length(Truth_table(:,3))
        if Truth_table(i,3) == 0
            Vdd_GND(i,1)    = "OFF";
            Vdd_GND(i,2)    = "ON";
            Half_Vdd(i,1)   = "OFF";
            Half_Vdd(i,2)   = "X";
        elseif Truth_table(i,3) == 1
            Vdd_GND(i,1)    = "OFF";
            Vdd_GND(i,2)    = "OFF";
            Half_Vdd(i,1)   = "ON";
            Half_Vdd(i,2)   = "ON";
        else
            Vdd_GND(i,1)    = "ON";
            Vdd_GND(i,2)    = "OFF";
            Half_Vdd(i,1)   = "X";
            Half_Vdd(i,2)   = "OFF";
        end
    end
end