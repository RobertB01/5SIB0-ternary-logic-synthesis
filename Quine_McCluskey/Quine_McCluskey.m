%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [QMC] = Quine_McCluskey(Truth_table, Opt)
    % Generate pull-up/pull-down tables
    [QMC.Vdd_GND.Table, QMC.Half_Vdd.Table] = Generate_pull_up_down_tables(Truth_table);

    QMC = OptimizeDontCares(Truth_table, QMC, Opt);

    % Don't care process for Half_Vdd table
%     QMC.Half_Vdd.Table  = Dont_cares(Truth_table, QMC.Half_Vdd.Table);
%     QMC.Half_Vdd.Table  = ["ON","OFF";"ON","OFF";"ON","ON";"ON","OFF";"ON","OFF";"ON","ON";"ON","ON";"ON","ON";"OFF","OFF"];
%     QMC                 = QMCprocess(Truth_table,QMC,Opt);

% 
%     QMC.Vdd_GND.Table       = array2table(QMC.Vdd_GND.Table,'VariableNames',{'U','D'});
%     QMC.Half_Vdd.Table      = array2table(QMC.Half_Vdd.Table,'VariableNames',{'U','D'});
end