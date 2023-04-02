function [GEO] = Geometric_post_optimization(GEO)
%GEOMETRIC_POST_OPTIMIZATION calculates the transistor cost for certain
%SOPs, only for 2 variables for now
SOPs = GEO.SOPs; 
GEO.transcount = NaN;

%operator = extractAfter(SOPs(1,1),".")

% if (length(SOPs(:,1))> 1)  %multiple options of SOPs to choose from
%     if (length(SOPs(1,:))) == 3  %one 3-to-1 multiplexer needed
%         MUXtrans = 18; % 3-to-1 multiplexer costs 18 CNTFETs
% 
%         transcount = [MUXtrans + Uoperator_cost(SOPs(1,:)), MUXtrans + Uoperator_cost(SOPs(2,:))]; %two options for SOP choose one with the lowest #transistors
%     elseif ((length(SOPs(1,:))) == 2) %one 2-to-1 multiplexer needed
%         MUXtrans = 4; % 2-to-1 multiplexer costs 4 CNTFETs
%           
%         transcount = [MUXtrans + Uoperator_cost(SOPs(1,:)), MUXtrans + Uoperator_cost(SOPs(2,:))];
%     else %only one term no multiplexer needed
%         transcount = [Uoperator_cost(SOPs(1,:)), Uoperator_cost(SOPs(2,:))];
%     end
% else
%     only one SOP to convert to # transistors
%      if (length(SOPs(1,:))) == 3  %one 3-to-1 multiplexer needed
%         MUXtrans = 18; % 3-to-1 multiplexer costs 18 CNTFETs
% 
%         transcount = [MUXtrans + Uoperator_cost(SOPs(1,:))];
%     elseif ((length(SOPs(1,:))) == 2) %one 2-to-1 multiplexer needed
%         MUXtrans = 4; % 2-to-1 multiplexer costs 4 CNTFETs
%           
%         transcount = [MUXtrans + Uoperator_cost(SOPs(1,:))];
%     else %only one term no multiplexer needed
%         transcount = [Uoperator_cost(SOPs(1,:))];
%      end
% end

if (length(SOPs(:,1))> 1)  %multiple options of SOPs to choose from
        MUXtrans = 18; % 3-to-1 multiplexer costs 18 CNTFETs
        transcount = [MUXtrans + Uoperator_cost(SOPs(1,:)), MUXtrans + Uoperator_cost(SOPs(2,:))]; %two options for SOP choose one with the lowest #transistors
else
    %only one SOP to convert to # transistors
        MUXtrans = 18; % 3-to-1 multiplexer costs 18 CNTFETs
        transcount = [MUXtrans + Uoperator_cost(SOPs(1,:))];
end

if length(transcount) == 2 %choose best option from two SOPs
    [count, Idx] = min(transcount);
    GEO.transcount = count;
    temp = GEO.SOPs(Idx,:); %lowest transcount SOP
    GEO.SOPs = [];
    GEO.SOPs = temp;
    return
else
    GEO.transcount = transcount;
    return;
end
end

