function [value] = COUNT(X,a)
%COUNT of a in X
value = sum(X(:) == a);
end

