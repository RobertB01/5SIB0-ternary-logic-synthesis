function display_graph(nodes, edges)
    for i = 1:size(nodes,1)
        disp("Node " + nodes{i,1} + " on level " + nodes{i,2} + " has outgoing edges:");
        if (height(edges{i,1,2})<3) % if it is 0 1 or 2
            disp("      LEFT: " + edges{i,1,1} + " ---> " + edges{i,1,2});
        else
            disp("      LEFT: " + edges{i,1,1} + " ---> " + "list(h=" + height(edges{i,1,2})+")");
        end
        if (height(edges{i,2,2})<3) % if it is 0 1 or 2
            disp("      RIGHT:  " + edges{i,2,1} + " ---> " + edges{i,2,2});
        else
            disp("      RIGHT: " + edges{i,2,1} + " ---> " + "list(h=" + height(edges{i,2,2})+")");
        end
    end

end