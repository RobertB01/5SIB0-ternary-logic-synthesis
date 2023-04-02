%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function printBDD(nodeNames, edges)
    for i = 1:length(nodeNames)
        disp(nodeNames(i) + " has edges:");
        if (~strcmp(edges(i,1,1),""))
            disp(edges(i,1,1) + " ------ > " + edges(i,1,2));
        end
        if (~strcmp(edges(i,2,1),""))
            disp(edges(i,2,1) + " ------ > " + edges(i,2,2));
        end
    end
end