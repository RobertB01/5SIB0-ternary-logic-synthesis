%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [BDD_OUT] = BDD(O, X)
    % Inputs:
    % O truth table as a list (O0, O1, .... O3^n -1)
    % Optional: X list of variable names
    
    % Count truth table variables n
    var_amnt = width(O)-1; % last column is output
    nodes_amnt = (3^var_amnt-1)/2;
    
    if (height(O) ~= 3^var_amnt)
        warning("The truth table may not have sufficient rows");
    end
    
    % When x is not supplied, name the variables
    if (nargin < 2) % the input variable names were not specified
        X = strings(1,var_amnt);
        for v = 1:var_amnt
            X(v) = "x" + string(v); % X = (x1, x2, x3, ..., xn)
        end
    end
    X(end+1) = "OUT"; % the output variable name
    %disp(X)

    % Create an empty graph
    [nodes, edges] = createEmptyGraph();
    
    % determine top node
    [choose_node, edge] = check_prop_10_11_12(X, O);
    edge_left = "_is_" + num2str(edge) + "?";
    edge_right = "_is_not_"+ num2str(edge) + "?";
    edge_left_dest = decompose_left(choose_node, O, X, edge);
    edge_right_dest_left_dest = decompose_right("left", choose_node, O, X, edge); % destination to the left after turning right
    edge_right_dest_right_dest = decompose_right("right", choose_node, O, X, edge); % destination to the right after turning right
    [nodes, edges] = updateGraph(nodes, edges, choose_node, 1, edge_left, edge_right, edge_left_dest, edge_right_dest_left_dest, edge_right_dest_right_dest);
    [nodes, edges] = removeDuplicates(nodes, edges);
    tbbd_1_inputs_only_done = 0;
    while(~tbbd_1_inputs_only_done)
        % search every edge for lists that are bigger than 3
        tbbd_1_inputs_only_done = 1;
        for i = 1:size(nodes,1)
            if(height(edges{i,1,2}) > 4)
                tbbd_1_inputs_only_done = 0;
                % further do algorithm
            end
        end
    end

    %display_graph(nodes, edges)

   % create a n*2 matrix, value 1 denotes that nti and pti gates should be
   % made (preventing duplicates):
   nti_pti_list = zeros(length(X)-1,2); % column 1 for nti, 2 for pti
    
    
   binary_inverter_count = 0;
   %disect the ternary 1 input gates
   [nodes, edges, nti_pti_list, binary_inverter_count] = fun_one_input(nodes, edges, nti_pti_list, binary_inverter_count, X);
       
    for i = 1:size(nodes,1)
        column = find(X == nodes{i,1}); 
        if(edges{i,1,1} == "_is_not_0?" || edges{i,1,1} == "_is_0?")
             nti_pti_list(column, 1) = 1;
        end
        if(edges{i,1,1} == "_is_not_2?" || edges{i,1,1} == "_is_2?")
            nti_pti_list(column, 2) = 1;
        end
    end

    inverter_count = sum(sum(nti_pti_list));
    tc = inverter_count*2 + binary_inverter_count*2 + size(nodes,1)*4;
    % create empty table for nti and pti for every input signal
    BDD_OUT.transistors = tc;
end


function [nodes, edges, nti_pti_list, binary_inverter_count] = fun_one_input(nodes, edges, nti_pti_list, binary_inverter_count, X)
    % check the 1 input ternary functions for propositions 2,3,4,5
    for i = 1:size(nodes,1) %go over all nodes
        for k = 1:2 %left and right edge
            if(height(edges{i,k,2}) == 4) % the destination is a table
                this_list = edges{i,k,2}; %retrieve the table the edge is going to
                X_new = this_list(1, :); % get inputs variable names from list
                O_new = str2double(this_list(2:end, :)); % get truthtable from list
                column = find(X == X_new{1}); %find the column index for variable name
          
                if(numel(unique(O_new(:,2))) == 1) %constant function
                    edges{i,k,2} = O_new(1,end); %either 0, 1 or 2
                else
                    %check for templates
                    if(O_new(1,2)  == 2 & O_new(2,2)  == 2 & O_new(3,2)  == 0)
                        %template 1
                        nti_pti_list(column, 2) = 1;
                        edges{i,k,2} = "PTI_" + num2str(X_new{1});
                    elseif(O_new(1,2)  == 0 & O_new(2,2)  == 2 & O_new(3,2)  == 2)
                        %template 2!
                         nti_pti_list(column, 1) = 1;
                         binary_inverter_count = binary_inverter_count+1;
                         edges{i,k,2} = "NTI_BINOT_" + num2str(X_new{1});
                    elseif(O_new(1,2)  == 0 & O_new(2,2)  == 0 & O_new(3,2)  == 2)
                        %template 3!
                         nti_pti_list(column, 2) = 1;
                         binary_inverter_count = binary_inverter_count+1;
                         edges{i,k,2} = "PTI_BINOT_" + num2str(X_new{1});
                    elseif(O_new(1,2)  == 0 & O_new(2,2)  == 1 & O_new(3,2)  == 2) %input = output
                        edges{i,k,2} = "valueOF_" + num2str(X_new{1});
                    else
                        %check for propositions 2 and 3
                        edges{i,k,2} = X_new{1};
                        o0 = O_new(1,2);
                        o1 = O_new(2,2);
                        o2 = O_new(3,2);
    
                        if(o0 == o1) %proposition 3 check
                          edge_left = "_is_2?";
                          edge_right = "_is_not_2?";
                          edge_left_dest = o2;
                          edge_right_dest = o1;
                          [nodes, edges] = updateGraph_small(nodes, edges, X_new{1}, nodes{i,2}+1, edge_left, edge_right, edge_left_dest, edge_right_dest);
                        
                        elseif(o1 == o2) %propisiton 2 holds
                          edge_left = "_is_0?";
                          edge_right = "_is_not_0?";
                          edge_left_dest = o0;
                          edge_right_dest = o1;
                          [nodes, edges] = updateGraph_small(nodes, edges, X_new{1}, nodes{i,2}+1, edge_left, edge_right, edge_left_dest, edge_right_dest);
                        else %proposition two and three dont hold, add another node
                          edge_left = "_is_0?";
                          edge_right = "_is_not_0?";
                          edge_left_dest = o0;
                          edge_right_dest_left_dest = o2; % destination to the left after turning right
                          edge_right_dest_right_dest = o1; % destination to the right after turning right
                          [nodes, edges] = updateGraph(nodes, edges, X_new{1}, nodes{i,2}+1, edge_left, edge_right, edge_left_dest, edge_right_dest_left_dest, edge_right_dest_right_dest);
                        end
                    end
                end
            end
        end
    end
end

function [nodes, edges] = removeDuplicates(nodes, edges)
    nodes = nodes;
    edges = edges;
end

function destination = decompose_right(direction, varname, O_in, X_in, i)
    column = find(X_in == varname); % find the column the variable is in
    X_in(column) = [];

    if (i == 0)
        new_i = 2;
        % the list must be made when setting variable= 2 for left, 1 for right
    else
        new_i = 0; % the list must be made when setting variable= 0 for left, 1 for right
    end

    if (direction == "left")
        O_new_i = Decompose(O_in,column,new_i); % decompose along i
    else
        O_new_i = Decompose(O_in,column,1); % right always has the 1 to decompose
    end
    destination = [X_in; O_new_i];
end

function destination = decompose_left(varname, O_in, X_in, i)
    column = find(X_in == varname); % find the column the variable is in
    O_new_i = Decompose(O_in,column,i); % decompose along i
    X_in(column) = []; %remove from variables

    if(height(O_new_i) > 1)
        destination  = [X_in; O_new_i];
    else
        destination = O_new_i;
    end
end

function [node_pick, edge_signal, l_left, l_right] = check_prop_10_11_12(X_new, O_new)
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
            %disp("Proposition 10");
            node_pick = varname;
            decompose = 1;
            % remove variable from variable list as it does not matter
            X_new(column) = []; %remove from variables
            %updateGraph(nodes, edges, amntNodesAdded, varname, O_new_0);
            break
        %Check for proposition 11
        elseif (O_new_0 == O_new_1 | O_new_1 == O_new_2) 
            %disp("Proposition 11");
            node_pick = varname;
            decompose = 1;
            X_new(column) = []; %remove from variables
            % Check whether proposition 2 or 3 should be taken:
            if (O_new_0 == O_new_1) % proposition 3
                %decompose with isVar2? as selection signal
                edge_signal = 2;
            else
                edge_signal = 0;
            end
            %updateGraph(nodes, edges, varname, edge_signal);
            break
        %Check for proposition 12
        elseif (numel(unique(O_new_0(:, end)))==1 || numel(unique(O_new_2(:, end)))==1)  % one of these ternary functions is constant
            %disp("Proposition 12"); 
            node_pick = varname;
            decompose = 1;
            X_new(column) = []; %remove from variables
            if (numel(unique(O_new_0(:, end)))==1)
                %decompose with isVar0?  as selection signal
                edge_signal = 0;
            else
                edge_signal = 2;
            end
            %updateGraph(nodes, edges, amntNodesAdded, O_new1);
            break
         end
    end
    if(decompose == 0)% conditions for propositions 10, 11 and 12 are not met for any variable
                % decompose along MSD (what is the most significant digit,
                % how to determine it??
                %disp("No decomposition variables found, choose the MSD")
                MSD = X_new(1); % first one is chosen (most significant?)
                node_pick = MSD;
                edge_signal = 0;
    end
end
