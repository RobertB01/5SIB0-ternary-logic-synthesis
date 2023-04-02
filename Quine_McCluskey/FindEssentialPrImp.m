%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [PrImp, EPI] = FindEssentialPrImp(PIChart, PrImp)
    EPI(1,1) = "";
    PrImp = PIChart(2:end,1);
    % (for all m in Mint do)
    for j = 2:length(PIChart(1,:))
        % (if m is covered by only PrImp_i then)
        if sum(count(PIChart(:,j),"*")) == 1
            % (EPI <- PrImp_i)
            [row, col] = find(PIChart(:,j)=="*");
            if EPI(end,1) == ""
                EPI(end,1) = PIChart(row,1);
            else
                EPI(end+1,1) = PIChart(row,1);
            end
        % (end if)
        end
    % (end for)
    end
%     % Find nonessential prime implicants not covered by PrImp (PrImp <- PrImp - EPI)
    for i = 1:length(EPI)
        PrImp = erase(PrImp,EPI(i,1));
    end
    for i = length(PrImp):-1:1
        if PrImp(i,1) == ""
            PrImp(i) = [];
        end
    end
    if isempty(PrImp)
        PrImp(1,1) = "";
    end
end