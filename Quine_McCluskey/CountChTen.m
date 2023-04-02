%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ChTen] = CountChTen(SOP,Dir)
    ChTen = 0;
    for i = 1:length(SOP(:,1))
        if contains(SOP(i,1),"(A0+A2)")
            ChTen = ChTen + count(SOP(i,1),"(A0+A2)")*1;
        elseif contains(SOP(i,1),"(A1+A2)")
            ChTen = ChTen;
        elseif contains(SOP(i,1),"(A0+A1)")
            ChTen = ChTen;
        elseif contains(SOP(i,1),"A0")
            if Dir == "U"
                ChTen = ChTen + 1;
            end
        elseif contains(SOP(i,1),"A2")
            if Dir == "D"
                ChTen = ChTen + 1;
            end
        end
        if contains(SOP(i,1),"(B0+B2)")
            ChTen = ChTen + count(SOP(i,1),"(B0+B2)")*1;
        elseif contains(SOP(i,1),"(B1+B2)")
            ChTen = ChTen;
        elseif contains(SOP(i,1),"(B0+B1)")
            ChTen = ChTen;
        elseif contains(SOP(i,1),"B0")
            if Dir == "U"
                ChTen = ChTen + 1;
            end
        elseif contains(SOP(i,1),"B2")
            if Dir == "D"
                ChTen = ChTen + 1;
            end
        end
    end
end