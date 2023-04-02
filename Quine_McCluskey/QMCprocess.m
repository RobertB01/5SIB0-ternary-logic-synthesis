%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [QMC] = QMCprocess(Truth_table, QMC, Opt)
    % Extract minterms from tables (Mint <- Extract(PT))
    QMC.Vdd_GND.U.Mint      = ExtractMinterms(Truth_table,QMC.Vdd_GND.Table,"U", Opt);
    QMC.Vdd_GND.D.Mint      = ExtractMinterms(Truth_table,QMC.Vdd_GND.Table,"D", Opt);
    QMC.Half_Vdd.U.Mint     = ExtractMinterms(Truth_table,QMC.Half_Vdd.Table,"U", Opt);
    QMC.Half_Vdd.D.Mint     = ExtractMinterms(Truth_table,QMC.Half_Vdd.Table,"D", Opt);

    % Assign minterms to initial implicants (Imp <- Mint)
    QMC.Vdd_GND.U.Imp       = QMC.Vdd_GND.U.Mint;
    QMC.Vdd_GND.D.Imp       = QMC.Vdd_GND.D.Mint;
    QMC.Half_Vdd.U.Imp      = QMC.Half_Vdd.U.Mint;
    QMC.Half_Vdd.D.Imp      = QMC.Half_Vdd.D.Mint;

    % Find all prime implicants by repeatedly merging implicants
    % Group implicants based on amount of '1' and '2' terms 
    QMC.Vdd_GND.U.Imp       = GroupImplicants(QMC.Vdd_GND.U.Imp);
    QMC.Vdd_GND.D.Imp       = GroupImplicants(QMC.Vdd_GND.D.Imp);
    QMC.Half_Vdd.U.Imp      = GroupImplicants(QMC.Half_Vdd.U.Imp);
    QMC.Half_Vdd.D.Imp      = GroupImplicants(QMC.Half_Vdd.D.Imp);

    % Merge implicants from adjacent groups and specify prime implicants
    [QMC.Vdd_GND.U.Imp_mrg, QMC.Vdd_GND.U.PrImp]    = MergeGroups(QMC.Vdd_GND.U.Imp, Opt);
    [QMC.Vdd_GND.D.Imp_mrg, QMC.Vdd_GND.D.PrImp]    = MergeGroups(QMC.Vdd_GND.D.Imp, Opt);
    [QMC.Half_Vdd.U.Imp_mrg, QMC.Half_Vdd.U.PrImp]  = MergeGroups(QMC.Half_Vdd.U.Imp, Opt);
    [QMC.Half_Vdd.D.Imp_mrg, QMC.Half_Vdd.D.PrImp]  = MergeGroups(QMC.Half_Vdd.D.Imp, Opt);
    
    % Construct prime implicant chart (construct PIChart (columns for Mint and rows for PrImp))
    QMC.Vdd_GND.U.PIChart   = ConstructPIChart(QMC.Vdd_GND.U.Mint, QMC.Vdd_GND.U.Imp_mrg, QMC.Vdd_GND.U.PrImp, Opt);
    QMC.Vdd_GND.D.PIChart   = ConstructPIChart(QMC.Vdd_GND.D.Mint, QMC.Vdd_GND.D.Imp_mrg, QMC.Vdd_GND.D.PrImp, Opt);
    QMC.Half_Vdd.U.PIChart  = ConstructPIChart(QMC.Half_Vdd.U.Mint, QMC.Half_Vdd.U.Imp_mrg, QMC.Half_Vdd.U.PrImp, Opt);
    QMC.Half_Vdd.D.PIChart  = ConstructPIChart(QMC.Half_Vdd.D.Mint, QMC.Half_Vdd.D.Imp_mrg, QMC.Half_Vdd.D.PrImp, Opt);

    % Identify essential prime implicants
    [QMC.Vdd_GND.U.PrImp, QMC.Vdd_GND.U.EPI]    = FindEssentialPrImp(QMC.Vdd_GND.U.PIChart, QMC.Vdd_GND.U.PrImp);
    [QMC.Vdd_GND.D.PrImp, QMC.Vdd_GND.D.EPI]    = FindEssentialPrImp(QMC.Vdd_GND.D.PIChart, QMC.Vdd_GND.D.PrImp);
    [QMC.Half_Vdd.U.PrImp, QMC.Half_Vdd.U.EPI]  = FindEssentialPrImp(QMC.Half_Vdd.U.PIChart, QMC.Half_Vdd.U.PrImp);
    [QMC.Half_Vdd.D.PrImp, QMC.Half_Vdd.D.EPI]  = FindEssentialPrImp(QMC.Half_Vdd.D.PIChart, QMC.Half_Vdd.D.PrImp);

    % Optimize PIChart
    if Opt == "TRUE"
        QMC.Vdd_GND.U.PIChart   = OptimizePIChart(QMC.Vdd_GND.U.PIChart);
        QMC.Vdd_GND.D.PIChart   = OptimizePIChart(QMC.Vdd_GND.D.PIChart);
        QMC.Half_Vdd.U.PIChart  = OptimizePIChart(QMC.Half_Vdd.U.PIChart);
        QMC.Half_Vdd.D.PIChart  = OptimizePIChart(QMC.Half_Vdd.D.PIChart);
    end

    % Produce SOPs
    QMC.Vdd_GND.U.SOPs      = ProduceSOPs(QMC.Vdd_GND.U.PIChart, QMC.Vdd_GND.U.PrImp, QMC.Vdd_GND.U.EPI);
    QMC.Vdd_GND.D.SOPs      = ProduceSOPs(QMC.Vdd_GND.D.PIChart, QMC.Vdd_GND.D.PrImp, QMC.Vdd_GND.D.EPI);
    QMC.Half_Vdd.U.SOPs     = ProduceSOPs(QMC.Half_Vdd.U.PIChart, QMC.Half_Vdd.U.PrImp, QMC.Half_Vdd.U.EPI);
    QMC.Half_Vdd.D.SOPs     = ProduceSOPs(QMC.Half_Vdd.D.PIChart, QMC.Half_Vdd.D.PrImp, QMC.Half_Vdd.D.EPI);

    % Post optimization
    [QMC.Vdd_GND.U.OSOP, QMC.Vdd_GND.U.CountTR]     = QMCPostOptimization(QMC.Vdd_GND.U.SOPs,"U");
    [QMC.Vdd_GND.D.OSOP, QMC.Vdd_GND.D.CountTR]     = QMCPostOptimization(QMC.Vdd_GND.D.SOPs,"D");
    [QMC.Half_Vdd.U.OSOP, QMC.Half_Vdd.U.CountTR]   = QMCPostOptimization(QMC.Half_Vdd.U.SOPs,"U");
    [QMC.Half_Vdd.D.OSOP, QMC.Half_Vdd.D.CountTR]   = QMCPostOptimization(QMC.Half_Vdd.D.SOPs,"D");
    
    % Determine parameters
    [QMC.Params]            = DetermineParams(QMC);
end