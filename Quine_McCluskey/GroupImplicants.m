%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Imp] = GroupImplicants(Imp)
    % (for all imp_i in Imp do)
    for i = 1:length(Imp(:,1))
        % (g_i = group(imp_i))
        Imp(i,2) = convertCharsToStrings(['[',num2str(count(Imp(i,1),"1")),',',num2str(count(Imp(i,1),"2")),']']);
    % (end for)
    end
end