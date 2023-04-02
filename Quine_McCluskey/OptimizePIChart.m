%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [PIChartOpt] = OptimizePIChart(PIChart)
    PIChartOpt = PIChart;
    if sum(contains(PIChartOpt(2:end,1),"A0(")) > 1
        PIChartOpt(contains(PIChartOpt(:,1),"A0("),:) = [];
        PIChartOpt(end+1,1) = "A0";
        PIChartOpt(end,2:end) = "";
        PIChartOpt(end,find(PIChart(1,:)== "0")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "1")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "2")) = "*";
    end
    if sum(contains(PIChartOpt(2:end,1),"A1(")) > 1
        PIChartOpt(contains(PIChartOpt(:,1),"A1("),:) = [];
        PIChartOpt(end+1,1) = "A1";
        PIChartOpt(end,2:end) = "";
        PIChartOpt(end,find(PIChart(1,:)== "3")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "4")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "5")) = "*";
    end
    if sum(contains(PIChartOpt(2:end,1),"A2(")) > 1
        PIChartOpt(contains(PIChartOpt(:,1),"A2("),:) = [];
        PIChartOpt(end+1,1) = "A2";
        PIChartOpt(end,2:end) = "";
        PIChartOpt(end,find(PIChart(1,:)== "6")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "7")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "8")) = "*";
    end
    if sum(contains(PIChartOpt(2:end,1),")B0")) > 1
        PIChartOpt(contains(PIChartOpt(:,1),")B0"),:) = [];
        PIChartOpt(end+1,1) = "B0";
        PIChartOpt(end,2:end) = "";
        PIChartOpt(end,find(PIChart(1,:)== "0")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "3")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "6")) = "*";
    end
    if sum(contains(PIChartOpt(2:end,1),")B1")) > 1
        PIChartOpt(contains(PIChartOpt(:,1),")B1"),:) = [];
        PIChartOpt(end+1,1) = "B1";
        PIChartOpt(end,2:end) = "";
        PIChartOpt(end,find(PIChart(1,:)== "1")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "4")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "7")) = "*";
    end
    if sum(contains(PIChartOpt(2:end,1),")B2")) > 1
        PIChartOpt(contains(PIChartOpt(:,1),")B2"),:) = [];
        PIChartOpt(end+1,1) = "B2";
        PIChartOpt(end,2:end) = "";
        PIChartOpt(end,find(PIChart(1,:)== "2")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "4")) = "*";
        PIChartOpt(end,find(PIChart(1,:)== "8")) = "*";
    end

    if sum(matches(PIChartOpt(:,1),"A0")) + sum(matches(PIChartOpt(:,1),"A1")) == 2
        mrg = "(A0+A1)";
        if sum(matches(PIChartOpt(:,1),mrg)) == 0
            PIChartOpt(end+1,1) = mrg;
            PIChartOpt(end,2:end) = "";
            PIChartOpt(end,find(PIChart(1,:)== "0")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "1")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "2")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "3")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "4")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "5")) = "*";
        end
    end
    if sum(matches(PIChartOpt(:,1),"A1")) + sum(matches(PIChartOpt(:,1),"A2")) == 2
        mrg = "(A1+A2)";
        if sum(matches(PIChartOpt(:,1),mrg)) == 0
            PIChartOpt(end+1,1) = mrg;
            PIChartOpt(end,2:end) = "";
            PIChartOpt(end,find(PIChart(1,:)== "3")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "4")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "5")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "6")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "7")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "8")) = "*";
        end
    end
    if sum(matches(PIChartOpt(:,1),"B0")) + sum(matches(PIChartOpt(:,1),"B1")) == 2
        mrg = "(B0+B1)";
        if sum(matches(PIChartOpt(:,1),mrg)) == 0
            PIChartOpt(end+1,1) = mrg;
            PIChartOpt(end,2:end) = "";
            PIChartOpt(end,find(PIChart(1,:)== "0")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "3")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "6")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "1")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "4")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "7")) = "*";
        end
    end
    if sum(matches(PIChartOpt(:,1),"B1")) + sum(matches(PIChartOpt(:,1),"B2")) == 2
        mrg = "(B1+B2)";
        if sum(matches(PIChartOpt(:,1),mrg)) == 0
            PIChartOpt(end+1,1) = mrg;
            PIChartOpt(end,2:end) = "";
            PIChartOpt(end,find(PIChart(1,:)== "1")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "4")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "7")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "2")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "5")) = "*";
            PIChartOpt(end,find(PIChart(1,:)== "8")) = "*";
        end
    end
end