%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [QMCopt] = OptimizeDontCares(Truth_table, QMC, Opt)
    [row, col] = find(QMC.Half_Vdd.Table == "X");
    QMCopt                      = QMC;
    QMCopt.Half_Vdd.Table(row,col) = "OFF";
    QMCopt                      = QMCprocess(Truth_table, QMCopt, Opt);
    TRopt                       = QMCopt.Params.Transistors;
    for i = 1:length(row(:,1))
        n   = nchoosek(1:length(row(:,1)),i);
        for j = 1:length(n(:,1))
            QMC.Half_Vdd.Table(row,col) = "OFF";
            for k = 1:i
                QMC.Half_Vdd.Table(row(n(j,k)),col(n(j,k))) = "ON";
            end
            QMC                     = QMCprocess(Truth_table, QMC, Opt);
            if QMC.Params.Transistors < TRopt
                TRopt               = QMC.Params.Transistors;
                QMCopt              = QMC;
            end
        end
    end
end