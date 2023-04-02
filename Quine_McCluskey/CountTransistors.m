%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [CountTR] = CountTransistors(SOP)
    CountTR = 0;
    for i = 1:length(SOP(:,1))
        if contains(SOP(i,1),"(A1+A2)")
            CountTR = CountTR + count(SOP(i,1),"(A1+A2)")*1;
        elseif contains(SOP(i,1),"(A0+A2)")
            CountTR = CountTR + count(SOP(i,1),"(A0+A2)")*2;
        elseif contains(SOP(i,1),"(A0+A1)")
            CountTR = CountTR + count(SOP(i,1),"(A0+A1)")*1;
        elseif contains(SOP(i,1),"A0")
            CountTR = CountTR + 1;
        elseif contains(SOP(i,1),"A2")
            CountTR = CountTR + 1;
        elseif contains(SOP(i,1),"A1")
            CountTR = CountTR + 2;
        end
        if contains(SOP(i,1),"(B1+B2)")
            CountTR = CountTR + count(SOP(i,1),"(B1+B2)")*1;
        elseif contains(SOP(i,1),"(B0+B2)")
            CountTR = CountTR + count(SOP(i,1),"(B0+B2)")*2;
        elseif contains(SOP(i,1),"(B0+B1)")
            CountTR = CountTR + count(SOP(i,1),"(B0+B1)")*1;
        elseif contains(SOP(i,1),"B0")
            CountTR = CountTR + 1;
        elseif contains(SOP(i,1),"B2")
            CountTR = CountTR + 1;
        elseif contains(SOP(i,1),"B1")
            CountTR = CountTR + 2;
        end
    end
end