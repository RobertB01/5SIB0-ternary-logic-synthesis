%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [OSOP,CountTR_OSOP] = QMCPostOptimization(SOPs,Dir)
    % Assume first OSOP
    % (OSOP = SOP1)
    OSOP            = SOPs(:,1);
    CountTR_OSOP    = CountTransistors(OSOP);
    ChTen_OSOP      = CountChTen(OSOP,Dir);
    % (for i = 1 to N do)
    for i = 1:length(SOPs(1,:))
        CountTR_SOP = CountTransistors(SOPs(:,i));
        ChTen_SOP   = CountChTen(SOPs(:,i),Dir);
        % (if CountTR(OSOP) > CountTR(SOPi) then)
        if CountTR_OSOP > CountTR_SOP
            % (OSOP = SOPi)
            OSOP    = SOPs(:,i);
        % (else if CountTR(OSOP) = CountTR(SOPi) then)
        elseif CountTR_OSOP == CountTR_SOP
            % (if ChTen(OSOP) > ChTen(SOPi) then)
            if ChTen_OSOP > ChTen_SOP
                % (OSOP = SOPi)
                OSOP= SOPs(:,i);
            % (end if)
            end
        % (else)
        else
            % (OSOP = OSOP)
            OSOP = OSOP;
        % (end if)
        end
        CountTR_OSOP    = CountTransistors(OSOP);
        ChTen_OSOP      = CountChTen(OSOP,Dir);
    % (end for)
    end
end