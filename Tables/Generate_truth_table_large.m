%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Truth_table] = Generate_truth_table(GateName, inputAmnt, outputAmnt)
 
    % Check if gate output amount makes sense
    if (outputAmnt > 1 && ~ismember(GateName, ["SUM", "PRODUCT", "MULTIPLIER", "FULLADDER", "HALFADDER"]))
        warning(GateName + " ternary gate only has one output");
    end

    % Generate input variables
    for i = 1:inputAmnt
        for j = 1:3^inputAmnt
            Truth_table(j,inputAmnt-i+1) = floor(mod(j-1,3^(i))/3^(i-1));
        end
    end

    % Generate Y
    if GateName == "SUM"
        if (inputAmnt < outputAmnt)
            warning("There more output variables than needed for SUM, resulting in rows of zeros");
        end
        for k = 1:outputAmnt
            for i = 1:length(Truth_table(:,1))
                wholesum = sum(Truth_table(i,1:inputAmnt));
                wholesum = floor(wholesum/3^(outputAmnt-k));
                Truth_table(i,inputAmnt+k)   = mod(wholesum,3);
            end
        end
    end
    if GateName == "AND"
        for i = 1:length(Truth_table(:,1))
            Truth_table(i,inputAmnt+1)   = min(Truth_table(i,1:inputAmnt));
        end
    end
    if GateName == "OR"
        for i = 1:length(Truth_table(:,1))
            Truth_table(i,inputAmnt+1)   = max(Truth_table(i,1:inputAmnt));
        end
    end

    if GateName == "CARRY"
        for i = 1:length(Truth_table(:,1))
            Truth_table(i,3) = floor(sum(Truth_table(i,1:2))/3);
        end
    end
    if GateName == "NCARRY"
        for i = 1:length(Truth_table(:,1))
            if Truth_table(i,1) + Truth_table(i,2) >= 3
                Truth_table(i,3) = 1;
            else
                Truth_table(i,3) = 2;
            end
        end
    end
    if GateName == "NANY"
        for i = 1:length(Truth_table(:,1))
            if (all(Truth_table(i,1:inputAmnt) == 2))
                Truth_table(i,inputAmnt+1) = 0;
            elseif (all(Truth_table(i,1:inputAmnt) ~= 2))
                Truth_table(i,inputAmnt+1) = 2;
            else
                Truth_table(i,inputAmnt+1) = 1;
            end
        end
    end


    if GateName == "AVERAGE"
        for i = 1:length(Truth_table(:,1))
            Truth_table(i,inputAmnt+1)   = floor(mean(Truth_table(i,1:inputAmnt)));
        end
    end
    if GateName == "MULTIPLIER"
        for i = 1:length(Truth_table(:,1))
            Truth_table(i,3) = mod(Truth_table(i,1)*Truth_table(i,2),3);
            Truth_table(i,4) = floor(sum(Truth_table(i,1:2))/3);
        end
    end

    if GateName == "HALFADDER"
        for i = 1:length(Truth_table(:,1))
            Truth_table(i,3)    = Truth_table(i,1) + Truth_table(i,2);
            if Truth_table(i,3) >= 3
                Truth_table(i,3)= Truth_table(i,3) - 3;
            end
            if Truth_table(i,1) + Truth_table(i,2) >= 3
                Truth_table(i,4) = 1;
            else
                Truth_table(i,4) = 2;
            end
        end
    end

    if GateName == "FULLADDER"
        for i = 1:length(Truth_table(:,1))
             Truth_table(i,4) = mod(sum(Truth_table(i,1:inputAmnt)), 3);
             Truth_table(i,5) = floor(sum(Truth_table(i,1:inputAmnt))/3);

        end
    end
    
    if GateName == "BUFFER" % used for intermediate coding
        clear Truth_table
        Truth_table(:,1) = [0 1 2];
        Truth_table(:,2) = [0 1 2];
    end
end