%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [PIChart] = ConstructPIChart(Mint, Imp_mrg, PrImp, Opt)
    if Mint(1,1) ~= ""
        for i = 1:length(Mint(:,1))
            a_i     = str2double(extract(Mint(i,1),2));
            b_i     = str2double(extract(Mint(i,1),4));
            Mint(i,2) = a_i*3 + b_i;
        end
        PIChart(1,:) = string(zeros(1,length(unique(Mint(:,2)))+1));
        PIChart(1,2:end) = unique(Mint(:,2))';
        PIChart(1,1) = "";
        if Opt == "TRUE"
            for i = 1:length(Mint(:,1))
                PIChart(end+1,find(PIChart(1,:)==Mint(i,2))) = "*";
                PIChart(end,find(PIChart(1,:)~=Mint(i,2))) = "";
                PIChart(end,1) = Mint(i,1);
            end
        end
        if PrImp ~= ""
            for i = 1:length(PrImp(:,1))
                a_i     = str2double(extract(PrImp(i,1),2));
                b_i     = str2double(extract(PrImp(i,1),4));
                PrImp(i,2) = a_i*3 + b_i;
                PIChart(end+1,find(PIChart(1,:)==PrImp(i,2))) = "*";
                PIChart(end,find(PIChart(1,:)~=PrImp(i,2))) = "";
                PIChart(end,1) = PrImp(i,1);
            end
        end
        if Imp_mrg ~= ""
            for i = 1:length(Imp_mrg(:,1))
                a_i     = str2double(extract(Imp_mrg(i,3),2));
                b_i     = str2double(extract(Imp_mrg(i,3),4));
                a_j     = str2double(extract(Imp_mrg(i,4),2));
                b_j     = str2double(extract(Imp_mrg(i,4),4));
                if length(Imp_mrg(i,:)) > 4
                    a_k     = str2double(extract(Imp_mrg(i,5),2));
                    b_k     = str2double(extract(Imp_mrg(i,5),4));
                    a_l     = str2double(extract(Imp_mrg(i,6),2));
                    b_l     = str2double(extract(Imp_mrg(i,6),4));
                    Imp_mrg(i,7) = num2str(a_i*3 + b_i);
                    PIChart(end+1,find(PIChart(1,:)==Imp_mrg(i,7))) = "*";
                    PIChart(end,find(PIChart(1,:)~=Imp_mrg(i,7))) = "";
                    Imp_mrg(i,8) = num2str(a_j*3 + b_j);
                    PIChart(end,find(PIChart(1,:)==Imp_mrg(i,8))) = "*";
                    PIChart(end,1) = Imp_mrg(i,1);
                    Imp_mrg(i,9) = num2str(a_k*3 + b_k);
                    PIChart(end,find(PIChart(1,:)==Imp_mrg(i,9))) = "*";
                    Imp_mrg(i,10) = num2str(a_l*3 + b_l);
                    PIChart(end,find(PIChart(1,:)==Imp_mrg(i,10))) = "*";
                else
                    Imp_mrg(i,5) = num2str(a_i*3 + b_i);
                    PIChart(end+1,find(PIChart(1,:)==Imp_mrg(i,5))) = "*";
                    PIChart(end,find(PIChart(1,:)~=Imp_mrg(i,5))) = "";
                    Imp_mrg(i,6) = num2str(a_j*3 + b_j);
                    PIChart(end,find(PIChart(1,:)==Imp_mrg(i,6))) = "*";
                    PIChart(end,1) = Imp_mrg(i,1);
                end
                               
            end
        end
    else
            PIChart = "";
    end
end