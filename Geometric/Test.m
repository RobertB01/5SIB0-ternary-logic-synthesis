function [text] = Test(Truth_table)
    m = length(Truth_table); %number of minterms (9 minterms for 2 variable functions)
    n = log10(m)/log10(3); %number of variables
    X = Truth_table(:,end);  %required output table
    A = Truth_table(:,2); %input A
    B = Truth_table(:,1); %input B


    [text] = Unary_operator([2; 2; 0;], "A")




end

