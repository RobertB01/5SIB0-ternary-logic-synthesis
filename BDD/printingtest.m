
Truth_table(:,1) = [0 1 2];
Truth_table(:,2) = [0 1 2];
% count truth table variables
var_amnt = width(Truth_table)-1 % last column is output F
nodes_amnt = (3^var_amnt-1)/2


nodenames = ["x" "y" "z"];
edges = zeros(2, 7);
edges(1,1) = "x"

function printbdd(nodenames, adj_matrix)
% prints bdd


end

