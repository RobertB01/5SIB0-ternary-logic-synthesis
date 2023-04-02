function [transcount] = Uoperator_cost(SOP)
%Uperator_cost calculates the transistor count for the unary operators in a
%certain SOP
transcount = 0;
operators = strings(length(SOP(1,:)),1);
for n = 1:length(SOP(1,:)) %get unary operators only
    operators(n) = extractAfter(SOP(n),".");
end

check_variable = sum(contains(operators(:),"A","IgnoreCase", false));
if check_variable > 0 %check for String variable
    String_variable = "A";
else
    String_variable = "B";
end

options = [
    String_variable, 0, 5;
    String_variable + "p", 2, 24;
    %String_variable + "n", 2;
    "inv(" + String_variable + ")", 6, 21;
    String_variable + "^1", 7, 15;
    String_variable + "^2", 7, 19;
    String_variable + "0", 2, 18;
    String_variable + "1", 4, 6;
    String_variable + "2", 4, 2;
    "inv(" + String_variable + "n)", 4, 8;
    "inv(" + String_variable + "^1)", 7, 11;
    "inv(" + String_variable + "^2)", 7, 7;
    "inv(" + String_variable + "1)", 4, 20;
    "1." + String_variable, 5, 4; %%%
    "1." + String_variable + "p", 8, 12; %%%
    "1." + String_variable + "n", 5, 9;
    "1." + String_variable + "^2", 8, 10;
    "1." + String_variable + "1", 8, 3;
    "1." + String_variable + "2", 5, 1;
    "(1 + " + String_variable + ")", 5, 14;
    "(1 + " + String_variable + "p)", 5, 25;
    "(1 + " + String_variable + "n)", 5, 22;
    "(1 + " + String_variable + "^1)",8, 16;
    "(1 + inv(" + String_variable + "0))", 5, 17;
    "(1 + inv(" + String_variable + "1))", 8 23;
    "1", 0, 13;
    "2", 0, 26;
    "None", NaN, NaN;
    ];

operators = unique(operators);
inv_cost = [0];
for k = 1:length(operators) % matching the transistor count with the unary operator
    for l = 1:length(options)
        if strcmp(operators(k),options(l,1)) 
            transcount = transcount + str2num(options(l,2));

            opp = str2num(options(l,3));

            if (opp == 1 || opp == 2 || opp == 11 || opp == 12 || opp == 14 || opp == 18 || opp == 19 || opp == 20 || opp ==25)
                inv_cost(end+1) = 2;

                if (opp == 3 || opp == 4 || opp == 6 || opp == 8 || opp == 9 || opp == 15 || opp == 17 || opp == 22 || opp == 24)
                    inv_cost(end+1) = 4;
                end
            elseif (opp == 3 || opp == 4 || opp == 6 || opp == 8 || opp == 9 || opp == 15 || opp == 17 || opp == 22 || opp == 24)
                inv_cost(end+1) =2;
                if (opp == 7 || opp == 10 || opp == 16 || opp == 23)
                    inv_cost(end+1) = 4;
                end
            elseif (opp == 7 || opp == 10 || opp == 16 || opp == 23)
                inv_cost(end+1) = 4;
            else
                inv_cost(end+1) = 0;
            end

        end
    end
end

transcount + max(inv_cost);
end

