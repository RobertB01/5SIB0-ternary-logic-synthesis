%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars;
close all;
clc;

addpath("Tables\","Quine_McCluskey\","BDD\","Geometric\","Post_optimization\");

%% Generate pull-up/pull-down tables
% Generate truth table for desired gate (choose between AND, OR, SUM, NCARRY, NANY, CARRY, PRODUCT)
Truth_table = Generate_truth_table("AND");

%% Quine-McCluskey optimization
Opt         = "FALSE";
[QMC]       = Quine_McCluskey(Truth_table, Opt);
 
%% Geometric optimization
[GEO.SOPs]  = Geometric(Truth_table);
% Post optimization
[GEO]       = Geometric_post_optimization(GEO);

%% TBDD based optimization
[TBDD_OUT] = BDD(Truth_table); 

%% Complex gates
% Choose gate (HALF-ADDER, FULL-ADDER, MULTIPLIER) and method (QMC,BDD,GEO)
Gates        = ["HALF-ADDER","MULTIPLIER","FULL-ADDER"];
Timing = zeros(3,4);
for i =1:3
    tic;
    Transistors.TBDD    = ComplexGate(Gates(i), "TBDD", "FALSE");
    Timing(i,1) = toc;
    tic;
    Transistors.GEO     = ComplexGate(Gates(i), "GEO", "FALSE");
    Timing(i,2) = toc;
    tic
    Transistors.QMC     = ComplexGate(Gates(i), "QMC", "FALSE");
    Timing(i,3) = toc;
    tic;
    Transistors.QMCopt  = ComplexGate(Gates(i), "QMC", "TRUE");
    Timing(i,4) = toc;
    Transistors.Table   = array2table(["TBDD",num2str(Transistors.TBDD);"GEO",num2str(Transistors.GEO);"QMC",num2str(Transistors.QMC);"QMC (optimized)",num2str(Transistors.QMCopt)],'VariableNames',{'Method','# of transistors'});
    disp(["Complex gate: ",Gates(i)]);
    disp(Transistors.Table);
end

Timing_table = array2table(["TBDD",num2str(Timing(1,1)),num2str(Timing(2,1)), num2str(Timing(3,1));"GEO",num2str(Timing(1,2)),num2str(Timing(2,2)), num2str(Timing(3,2));"QMC",num2str(Timing(1,3)),num2str(Timing(2,3)), num2str(Timing(3,3));"QMC (optimized)",num2str(Timing(1,4)),num2str(Timing(2,4)), num2str(Timing(3,4))],'VariableNames',{'Method','Half adder','Multiplier', 'Full adder'});
disp("Runtime in seconds:");
disp(Timing_table);
%% Display results
Truth_table = array2table(Truth_table,'VariableNames',{'A','B','Y'});

