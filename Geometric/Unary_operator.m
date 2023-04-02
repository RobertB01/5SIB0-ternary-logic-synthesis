function [Unary_operator] = Unary_operator(A_in, String_variable)
%select unary operator based on A_in
%String_variable should be a string of the desired variable UPPERCASE!
%A_in should be vector of dim 3
%Unary_operator is string output


    if isequal(A_in,[0; 1; 2;])
        Unary_operator = String_variable;
        return
    elseif isequal(A_in,[2; 2; 0;])
        Unary_operator = [String_variable + "p"];
        return
    %elseif isequal(A_in,[2; 0; 0;])
    %   Unary_operator = [String_variable + "n"];
    %   return
    elseif isequal(A_in,[2; 1; 0;])
        Unary_operator = ["inv(" + String_variable + ")"];
        return
    elseif isequal(A_in,[1; 2; 0;])
        Unary_operator = [String_variable + "^1"];
        return
    elseif isequal(A_in,[2; 0; 1;])
        Unary_operator = [String_variable + "^2"];
        return
    elseif isequal(A_in,[2; 0; 0;])
        Unary_operator = [String_variable + "0"];
        return
    elseif isequal(A_in,[0; 2; 0;])
        Unary_operator = [String_variable + "1"];
        return
    elseif isequal(A_in,[0; 0; 2;])
        Unary_operator = [String_variable + "2"];
        return

    elseif isequal(A_in,[0; 2; 2;])
        Unary_operator = ["inv(" + String_variable + "n)"];
        return
    elseif isequal(A_in,[1; 0; 2;])
        Unary_operator = ["inv(" + String_variable + "^1)"];
        return
    elseif isequal(A_in,[0; 2; 1;])
        Unary_operator = ["inv(" + String_variable + "^2)"];
        return
    elseif isequal(A_in,[2; 0; 2;])
        Unary_operator = ["inv(" + String_variable + "1)"];
        return
    elseif isequal(A_in,[0; 1; 1;])
        Unary_operator = ["1." + String_variable];
        return
    elseif isequal(A_in,[1; 1; 0;])
        Unary_operator = ["1." + String_variable + "p"];
        return
    elseif isequal(A_in,[1; 0; 0;])
        Unary_operator = ["1." + String_variable + "n"];
        return
    elseif isequal(A_in,[1; 0; 1;])
        Unary_operator = ["1." + String_variable + "^2"];
        return
    elseif isequal(A_in,[0; 1; 0;])
        Unary_operator = ["1." + String_variable + "1"];
        return        
    elseif isequal(A_in,[0; 0; 1;])
        Unary_operator = ["1." + String_variable + "2"];
        return
    elseif isequal(A_in,[1; 1; 2;])
        Unary_operator = ["(1 + " + String_variable + ")"];
        return
    elseif isequal(A_in,[2; 2; 1;])
        Unary_operator = ["(1 + " + String_variable + "p)"];
        return
    elseif isequal(A_in,[2; 1; 1;])
        Unary_operator = ["(1 + " + String_variable + "n)"];
        return
    elseif isequal(A_in,[1; 2; 1;])
        Unary_operator = ["(1 + " + String_variable + "^1)"];
        return
    elseif isequal(A_in,[1; 2; 2;])
        Unary_operator = ["(1 + inv(" + String_variable + "0))"];
        return
    elseif isequal(A_in,[2; 1; 2;])
        Unary_operator = ["(1 + inv(" + String_variable + "1))"];
        return
    elseif isequal(A_in,[1; 1; 1;])
        Unary_operator = ["1"];
        return
    elseif isequal(A_in,[2; 2; 2;])
        Unary_operator = ["2"];
        return
    else
        Unary_operator = "None";
        return


        
    end

end

