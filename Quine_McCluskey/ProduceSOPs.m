%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [SOPs] = ProduceSOPs(PIChart, PrImp, EPI)
    OG_PIChart = PIChart;
    k = 2;
    % (for all ProperComb(PrImp) do)
    if PrImp ~= ""
        SOPs(1:length(PIChart(2:end,1)),1) = PIChart(2:end,1);
        for h = 2:length(PIChart(:,1))
            PIChart = OG_PIChart;
            PIChart(h,:) = [];
            n = 2;
            PIChart_i = PIChart;
            for i = 2:length(PIChart(:,1))
                % (Products <- EPI uniun ProperComb(PrImp))
                % (SOP <- sum(Products))
                viable_SOP = 0;
                if n <= length(PIChart(:,1))
                    for j = 2:length(PIChart(1,:))
                        if sum(count(PIChart(:,j),"*")) >= 1
                            viable_SOP = viable_SOP + 1;
                        end
                    end
                    if viable_SOP == length(PIChart(1,:))-1
                        SOPs(1:length(PIChart(2:end,1)),k) = PIChart(2:end,1);
                        k = k+1;
                    else
                        PIChart = PIChart_i;
                        n = n+1;
                    end
                    PIChart_i = PIChart;
                    if n <= length(PIChart(:,1))
                        PIChart(n,:) = [];
                    end
                end
            end
        end
    else
        SOPs = EPI;
    end
    % (end for)
end