%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [SOPs] = BDD2(O, X)
    % Inputs:
    % O truth table as a list (O0, O1, .... O3^n -1)
    % X list of variable names
    
    % count truth table variables n
    var_amnt = width(O)-1; % last column is output F
    nodes_amnt = (3^var_amnt-1)/2;
    
    if (height(O) ~= 3^var_amnt)
        warning("The truth table may not have sufficient rows");
    end
    
    if (nargin < 2) % the input variable names were not specified
        X = strings(1,var_amnt);
        for v = 1:var_amnt
            X(v) = "x" + string(v); % X = (x1, x2, x3, ..., xn)
        end
    end
    X(end+1) = "OUT";

    % Create a list [[X; O]]
    out_list{1} = [X; O];

    % Create an empty graph
    [nodes, edges] = createEmptyGraph(nodes_amnt);

    % Perform decomposition until single input ternary function is achieved
    outLength = height(O); % height of truth table
    while(outLength > 3) % Check if one input function
        for k = 1:length(out_list)
            this_list = out_list{k}; % get list index k from list
            X_new = this_list(1, :); % get inputs variable names from list
            O_new = str2double(this_list(2:end, :)); % get truthtable from list
            listnew = {};
            decompose = 0;
            for var = 1:length(X_new)-1 %-1 because OUT is not an input
                varname = X_new(var);
                column = find(X_new == varname); % find the column the variable is in
                O_new_0 = Decompose(O_new,column,0);
                O_new_1 = Decompose(O_new,column,1);
                O_new_2 = Decompose(O_new,column,2);
    
                %Check for propositions 10, 11, 12
                %Check for proposition 10
                if (O_new_0 == O_new_1 & O_new_0 == O_new_2) % its all the same
                    disp("Proposition 10");
                    decompose = 1;
                    % remove variable from variable list as it does not matter
                    X_new(column) = []; %remove from variables
                    listnew{end+1} = [X_new; O_new_0];
                    %updateGraph(nodes, edges, amntNodesAdded, varname, O_new_0);
                    break
                %Check for proposition 11
                elseif (O_new_0 == O_new_1 | O_new_1 == O_new_2) 
                    disp("Proposition 11");
                    decompose = 1;
                    X_new(column) = []; %remove from variables
                    % Check whether proposition 2 or 3 should be taken:
                    if (O_new_0 == O_new1) % proposition 3
                        %decompose with isVar2? as selection signal
                        edge_signal = 2;
                        listnew{end+1} = [X_new; O_new_0];
                        listnew{end+1} = [X_new; O_new_2];
                    else
                        edge_signal = 0;
                        listnew{end+1} = [X_new; O_new_1];
                        listnew{end+1} = [X_new; O_new_2];
                    end
                    %updateGraph(nodes, edges, varname, edge_signal);
                    break
                %Check for proposition 12
                elseif (numel(unique(O_new_0(:, end)))==1 || numel(unique(O_new_2(:, end)))==1)  % one of these ternary functions is constant
                    disp("Proposition 12"); 
               
                    decompose = 1;
                    X_new(column) = []; %remove from variables
                    if (numel(unique(O_new_0(end)))==1)
                        %decompose with isVar0?  as selection signal
                        edge_signal = 0;
                        listnew{end+1} = [X_new; O_new_1];
                        listnew{end+1} = [X_new; O_new_2];
                    else
                        edge_signal = 2;
                        listnew{end+1} = [X_new; O_new_0];
                        listnew{end+1} = [X_new; O_new_1];
                    end
                    %updateGraph(nodes, edges, amntNodesAdded, O_new1);
                    break
                end
            end

            if(decompose == 0)% conditions for propositions 10, 11 and 12 are not met for any variable
                % decompose along MSD (what is the most significant digit,
                % how to determine it??
                disp("No decomposition variables found, choose the MSD")
                MSD = X_new(1); % first one is chosen (most significant?)
                column = find(X_new == varname); % find the column the variable is in
                O_new_0 = Decompose(O_new,column,0);
                O_new_1 = Decompose(O_new,column,1);
                O_new_2 = Decompose(O_new,column,2);
                X_new(column) = []; %remove from variables
                listnew{end+1} = [X_new; O_new_0];
                listnew{end+1} = [X_new; O_new_1];
                listnew{end+1} = [X_new; O_new_2];
            end
        end
        %listnew = remove_fun(listnew);
        out_list = listnew;
        % check maxheight
        max_height = 0;
        for i = 1:length(out_list)
            cell_height = height(out_list{i});
            if cell_height > max_height
                max_height = cell_height;
            end
        end
        outLength = max_height-1;
    end
    % End of while loop reducing TDD into 1 input lists
    for list = 1:length(out_list)
        this_list = out_list{list};
        X_new = this_list(1, :);
        O_new = str2double(this_list(2:end, :));
        %disp(this_list);
    end

    for i = 1:length(out_list)
        disp(out_list{i})
    end
    SOPs = 0;
end


