function [nodes, edges] = updateGraph(nodes, edges, nodename, level, edgesignal_left, edgesignal_right, destleft, dest_r_l, dest_r_r)
    nodes{end+1,1} = nodename;
    nodes{end,2} = level;
    edges{end+1,1,1} = edgesignal_left; %left edge
    edges{end,1,2} = destleft;
    edges{end,2,1} = edgesignal_right; %right edge
    edges{end,2,2} = nodename;

    % create subnode with same name
    nodes{end+1,1} = nodename;
    nodes{end,2} = level+1;
    if(edgesignal_left == "_is_2?")
        edges{end+1,1,1} = "_is_0?";
        edges{end,2,1} = "_is_not_0?";
    else
        edges{end+1,1,1} = "_is_2?";
        edges{end,2,1} = "_is_not_2?";
    end
    edges{end,1,2} = dest_r_l;
    edges{end,2,2} = dest_r_r;
end

