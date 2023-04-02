%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Mint] = ExtractMinterms(Truth_table,Pull_table,Dir,Opt)
    j = 1;
    Mint = "";
    if Dir == "U"
        col = 1;
    elseif Dir == "D"
        col = 2;
    end
    for i = 1:length(Pull_table(:,1))
        if Pull_table(i,col) == "ON"
            Mint(j,:) = convertCharsToStrings(['A',num2str(Truth_table(i,1)),'B',num2str(Truth_table(i,2))]);
            j           = j + 1;
        end
    end
    if Opt == "TRUE"
        if sum(count(Pull_table(:,col),"ON")) == length(Pull_table(:,col))
            Mint = "";
        end
    end
end