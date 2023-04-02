%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function new_edges = connectNodes(edges, node_origin, node_dest, nodes, edge)
    %rows represent origin, columns destination

    % Check if BDD is still in good order
    if (length(edges) ~= length(nodes))
        warning("Adjancy matrix and amount of nodes do not match!");
    end
    if (~any(nodes(:) == node_dest))
        if(strcmp(node_dest, "0") || strcmp(node_dest, "1") || strcmp(node_dest, "2"))
            disp("Connect to output" + node_dest)
        else
            warning("Destination node does not exist");
        end
    end
    if (~any(nodes(:) == node_origin))
        warning("Origin node does not exist");
    end

    index_origin = find(nodes == node_origin); % find the column the variable is in
    index_destination = find(nodes == node_dest); % find the column the variable is in

    new_edges = edges;
    disp(new_edges(3,1,1))
    if(strcmp(new_edges(index_origin,1,1),""))
        new_edges(index_origin,1,1) = edge;
        new_edges(index_origin,1,2) = node_dest;
    else
        new_edges(index_origin,2,1) = edge;
        new_edges(index_origin,2,2) = node_dest;
    end
end