%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Transistors] = ComplexGate(Gate,Method, Opt)
    Transistors = 0;
    if Gate == "HALF-ADDER"
        if Method == "QMC"
            Truth_table = Generate_truth_table("SUM");
            [QMC]       = Quine_McCluskey(Truth_table, Opt);
            Transistors = Transistors + QMC.Params.Transistors;
            Truth_table = Generate_truth_table("NCARRY");
            [QMC]       = Quine_McCluskey(Truth_table, Opt);
            Transistors = Transistors + QMC.Params.Transistors;
        elseif Method == "GEO"
            Truth_table = Generate_truth_table("SUM");
            [GEO.SOPs]      = Geometric(Truth_table);
            [GEO] = Geometric_post_optimization(GEO);
            Transistors = Transistors + GEO.transcount;
            Truth_table = Generate_truth_table("NCARRY");
            [GEO.SOPs]      = Geometric(Truth_table);
            [GEO] = Geometric_post_optimization(GEO);
            Transistors = Transistors + GEO.transcount;
        else
            Truth_table = Generate_truth_table("SUM");
            [BDD_out]      = BDD(Truth_table);
            Transistors = Transistors + BDD_out.transistors;
            Truth_table = Generate_truth_table("NCARRY");
            [BDD_out]      = BDD(Truth_table);
            Transistors = Transistors + BDD_out.transistors;
        end
    elseif Gate == "FULL-ADDER"
        if Method == "QMC"
            Truth_table = Generate_truth_table("SUM");
            [QMC]       = Quine_McCluskey(Truth_table, Opt);
            Transistors = Transistors + 2*QMC.Params.Transistors;
            Truth_table = Generate_truth_table("NCARRY");
            [QMC]       = Quine_McCluskey(Truth_table, Opt);
            Transistors = Transistors + 2*QMC.Params.Transistors;
            Truth_table = Generate_truth_table("NANY");
            [QMC]       = Quine_McCluskey(Truth_table, Opt);
            Transistors = Transistors + QMC.Params.Transistors;

        elseif Method == "GEO"
            Truth_table = Generate_truth_table("SUM");
            [GEO.SOPs]      = Geometric(Truth_table);
            [GEO] = Geometric_post_optimization(GEO);
            Transistors = Transistors + 2*GEO.transcount;
            Truth_table = Generate_truth_table("NCARRY");
            [GEO.SOPs]      = Geometric(Truth_table);
            [GEO] = Geometric_post_optimization(GEO);
            Transistors = Transistors + 2*GEO.transcount;
            Truth_table = Generate_truth_table("NANY");
            [GEO.SOPs]      = Geometric(Truth_table);
            [GEO] = Geometric_post_optimization(GEO);
            Transistors = Transistors + GEO.transcount;
        else
            Truth_table = Generate_truth_table("SUM");
            [BDD_out]      = BDD(Truth_table);
            Transistors = Transistors + 2*BDD_out.transistors;
            Truth_table = Generate_truth_table("NCARRY");
            [BDD_out]      = BDD(Truth_table);
            Transistors = Transistors + 2*BDD_out.transistors;
            Truth_table = Generate_truth_table("NANY");
            [BDD_out]      = BDD(Truth_table);
            Transistors = Transistors + BDD_out.transistors;
        end
    elseif Gate == "MULTIPLIER"
        if Method == "QMC"
            Truth_table = Generate_truth_table("PRODUCT");
            [QMC]       = Quine_McCluskey(Truth_table, Opt);
            Transistors = Transistors + QMC.Params.Transistors;
            Truth_table = Generate_truth_table("CARRY");
            [QMC]       = Quine_McCluskey(Truth_table, Opt);
            Transistors = Transistors + QMC.Params.Transistors;
        elseif Method == "GEO"
            Truth_table = Generate_truth_table("PRODUCT");
            [GEO.SOPs]      = Geometric(Truth_table);
            [GEO] = Geometric_post_optimization(GEO);
            Transistors = Transistors + GEO.transcount;
            Truth_table = Generate_truth_table("CARRY");
            [GEO.SOPs]      = Geometric(Truth_table);
            [GEO] = Geometric_post_optimization(GEO);
            Transistors = Transistors + GEO.transcount;
        else
            Truth_table = Generate_truth_table("PRODUCT");
            [BDD_out]      = BDD(Truth_table);  
            Transistors = Transistors + BDD_out.transistors;
            Truth_table = Generate_truth_table("CARRY");
            [BDD_out]      = BDD(Truth_table); 
            Transistors = Transistors + BDD_out.transistors;
        end
    end
end