function [nodes, edges] = updateGraph_small(nodes, edges, nodename, level, edgesignal_left, edgesignal_right, destleft, destright)
    nodes{end+1,1} = nodename;
    nodes{end,2} = level;
    edges{end+1,1,1} = edgesignal_left; %left edge
    edges{end,1,2} = destleft;
    edges{end,2,1} = edgesignal_right; %right edge
    edges{end,2,2} = destright;
end