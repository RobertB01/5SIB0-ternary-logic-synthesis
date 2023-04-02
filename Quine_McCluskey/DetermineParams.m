%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Params] = DetermineParams(QMC)
    Params.Transistors  = QMC.Vdd_GND.U.CountTR + QMC.Vdd_GND.D.CountTR + QMC.Half_Vdd.U.CountTR + QMC.Half_Vdd.D.CountTR + 2;
end