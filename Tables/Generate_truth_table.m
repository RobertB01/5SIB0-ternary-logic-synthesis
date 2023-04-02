%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Truth_table] = Generate_truth_table(Gate)
    % Generate A and B
    Truth_table(:,1)   = [0; 0; 0; 1; 1; 1; 2; 2; 2];
    Truth_table(:,2)   = [0; 1; 2; 0; 1; 2; 0; 1; 2];
    % Generate Y
    if Gate == "SUM"
        for i = 1:length(Truth_table(:,1))
            Truth_table(i,3)    = Truth_table(i,1) + Truth_table(i,2);
            if Truth_table(i,3) >= 3
                Truth_table(i,3)= Truth_table(i,3) - 3;
            end
        end
    end
    if Gate == "AND"
        for i = 1:length(Truth_table(:,1))
            Truth_table(i,3)    = min(Truth_table(i,1),Truth_table(i,2));
        end
    end
    if Gate == "OR"
        for i = 1:length(Truth_table(:,1))
            Truth_table(i,3)    = max(Truth_table(i,1),Truth_table(i,2));
        end
    end
%     if Gate == "CARRY"
%         for i = 1:length(Truth_table(:,1))
%             if Truth_table(i,1) + Truth_table(i,2) >= 3
%                 Truth_table(i,3) = 1;
%             else
%                 Truth_table(i,3) = 0;
%             end
%         end
%     end
    if Gate == "CARRY"
        for i = 1:length(Truth_table(:,1))
            if (Truth_table(i,1) == 2) && (Truth_table(i,2) == 2)
                Truth_table(i,3) = 1;
            else
                Truth_table(i,3) = 0;
            end
        end
    end
    if Gate == "NCARRY"
        for i = 1:length(Truth_table(:,1))
            if Truth_table(i,1) + Truth_table(i,2) >= 3
                Truth_table(i,3) = 1;
            else
                Truth_table(i,3) = 2;
            end
        end
    end
    if Gate == "NANY"
        for i = 1:length(Truth_table(:,1))
            if (Truth_table(i,1) == 2)&&(Truth_table(i,2) == 2)
                Truth_table(i,3) = 0;
            elseif (Truth_table(i,1) ~= 2)&&(Truth_table(i,2) ~= 2)
                Truth_table(i,3) = 2;
            else
                Truth_table(i,3) = 1;
            end
        end
    end
    if Gate == "PRODUCT"
        for i = 1:length(Truth_table(:,1))
            Truth_table(i,3) = mod(Truth_table(i,1)*Truth_table(i,2),3);
        end
    end
    if Gate == "BUFFER" % used for intermediate coding
        clear Truth_table
        Truth_table(:,1) = [0 1 2];
        Truth_table(:,2) = [0 1 2];
    end
end