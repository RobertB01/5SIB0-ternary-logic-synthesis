function [value] = AND(X,a)
%And of all elements of X with a
    X_min = min(X);
    value = min(X_min,a);
end

