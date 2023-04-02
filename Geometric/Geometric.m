%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [SOPs] = Geometric(Truth_table)
    m = length(Truth_table); %number of minterms (9 minterms for 2 variable functions)
    n = log10(m)/log10(3); %number of variables
    X = Truth_table(:,end);  %required output table
    A = Truth_table(:,2); %input A
    B = Truth_table(:,1); %input B
    one_vector = ones(9,1);
    two_vector = 2.*ones(9,1);

    for k = 1:(m/9)
        %values of Hi and Vi
        H = [X(1) + X(2) + X(3), X(4) + X(5) + X(6), X(7) + X(8) + X(9)];
        V = [X(1) + X(4) + X(7), X(2) + X(5) + X(8), X(3) + X(6) + X(9)];


        if (sum(X)==0)
            F = 0; %zero function
            return
        else
            if (isequal(A,X) || isequal(B,X)) %check for proposition 1
                %write output as identity function  or as constant function
                if(isequal(A,X))
                    F = A;
                    return
                else
                    F = B;
                    return
                end
            end
            if (isequal(X,one_vector))
                F = 1;
                return
            end
            if (isequal(X,two_vector))
                F = 2;
                return
            end
            if (H(1) == 0 || H(2) == 0 || H(3) == 0) && (V(1) == 0 || V(2) == 1 || V(3) == 0)

                if ( H(1) + H(2) == 0 || H(2) + H(3) == 0 || H(3) + H(1) == 0)
                    %choose the unary operators along the horizontal
                    %direction (proposition 2)
                    if (H(1) + H(2) == 0) %Horizontal third row is non zero
                        F = ["b2." + Unary_operator(X(7:9),"A")];

                    elseif (H(2) + H(3) == 0)
                        F = ["b0." + Unary_operator(X(1:3),"A")];

                    else
                        F = ["b1." + Unary_operator(X(4:6),"A")];
                    end
                elseif (V(1) + V(2) == 0 || V(2) + V(3) == 0 || V(3) + V(1) == 0)
                    %choose the unary operators alon the vertical direction
                    %(corollary 1)
                    if (V(1) + V(2) == 0) %Vertical third row is non zero
                        F = ["a2." + Unary_operator(X([3 6 9]),"B")];

                    elseif (V(2) + V(3) == 0) %vertical first row is non zero
                        F = ["a0." + Unary_operator(X([1 4 7]),"B")];

                    else %Vertical second row is non zero
                        F = ["a1." + Unary_operator(X([2 5 8]),"B")];
                    end
                else
                    %scan in both horizontal and vertical directions
                    %(Proposition 3)
                    % there is a zero row in the vertical AND horizontal
                    % direction
                    if H(1) == 0
                        if V(1) == 0
                            F = ["a1." + Unary_operator(X([2 5 8]),"B") "a2." + Unary_operator(X([3 6 9]),"B"); "b1." + Unary_operator(X(4:6),"A") "b2." + Unary_operator(X(7:9),"A")];
                        elseif V(2) == 0
                            F = ["a0." + Unary_operator(X([1 4 7]),"B") "a2." + Unary_operator(X([3 6 9]),"B"); "b1." + Unary_operator(X(4:6),"A") "b2." + Unary_operator(X(7:9),"A")];
                        elseif V(3) == 0
                            F = ["a0." + Unary_operator(X([1 4 7]),"B") "a1." + Unary_operator(X([2 5 8]),"B"); "b1." + Unary_operator(X(4:6),"A") "b2." + Unary_operator(X(7:9),"A")];                        
                        end
                    elseif H(2) == 0
                        if V(1) == 0
                            F = ["a1." + Unary_operator(X([2 5 8]),"B") "a2." + Unary_operator(X([3 6 9]),"B"); "b0." + Unary_operator(X(1:3),"A") "b2." + Unary_operator(X(7:9),"A")];
                        elseif V(2) == 0
                            F = ["a0." + Unary_operator(X([1 4 7]),"B") "a2." + Unary_operator(X([3 6 9]),"B"); "b0." + Unary_operator(X(1:3),"A") "b2." + Unary_operator(X(7:9),"A")];
                        elseif V(3) == 0
                            F = ["a0." + Unary_operator(X([1 4 7]),"B") "a1." + Unary_operator(X([2 5 8]),"B"); "b0." + Unary_operator(X(1:3),"A") "b2." + Unary_operator(X(7:9),"A")];                        
                        end
                    elseif H(3) == 0
                        if V(1) == 0
                            F = ["a1." + Unary_operator(X([2 5 8]),"B") "a2." + Unary_operator(X([3 6 9]),"B"); "b1." + Unary_operator(X(4:6),"A") "b0." + Unary_operator(X([3 6 9]),"A")];
                        elseif V(2) == 0
                            F = ["a0." + Unary_operator(X([1 4 7]),"B") "a2." + Unary_operator(X([3 6 9]),"B"); "b1." + Unary_operator(X(4:6),"A") "b0." + Unary_operator(X(1:3),"A")];
                        elseif V(3) == 0
                            F = ["a0." + Unary_operator(X([1 4 7]),"B") "a1." + Unary_operator(X([2 5 8]),"B"); "b1." + Unary_operator(X(4:6),"A") "b0." + Unary_operator(X(1:3),"A")];                        
                        end
                    end
                end
            else
                %scan in both horizontal and vertical directions
                %(Proposition 3)
                % first see if there is atleast one zero row
                if H(1) == 0 || H(2) == 0 || H(3) == 0 || V(1) == 0 || V(2) == 0 || V(3) == 0 %there is some zero row
                    %check two horzitonal rows zero or two vertical rows
                    %zero
                    if (H(1) == 0 && H(2) == 0)
                        F = ["b2." + Unary_operator(X(7:9),"A")];
                    elseif (H(2) == 0 && H(3) == 0)
                        F = ["b0." + Unary_operator(X(1:3),"A")]; 
                    elseif (H(1) == 0 && H(3) == 0)
                        F = ["b1." + Unary_operator(X(4:6),"A")]; 
                    elseif (V(1) == 0 && V(2) == 0)
                        F = ["a2." + Unary_operator(X([3 6 9]),"B")]; 
                    elseif (V(2) == 0 && V(3) == 0)
                        F = ["a0." + Unary_operator(X([1 4 7]),"B")]; 
                    elseif (V(1) == 0 && V(3) == 0)
                        F = ["a1." + Unary_operator(X([2 5 6]),"B")]; 
                    %check if one row of horizontal or vertical is zero
                    elseif (H(1)==0)
                        F = ["b1." + Unary_operator(X(4:6),"A") "b2." + Unary_operator(X(7:9))];
                    elseif (H(2)==0)
                        F = ["b0." + Unary_operator(X(1:3),"A") "b2." + Unary_operator(X(7:9))];
                    elseif (H(3)==0)
                        F = ["b0." + Unary_operator(X(1:3),"A") "b1." + Unary_operator(X(4:6))];
                    elseif (V(1)==0)
                        F = ["a1." + Unary_operator(X([2 5 8]),"B") "a2." + Unary_operator(X([3 6 9]))];
                    elseif (V(2)==0)
                        F = ["a0." + Unary_operator(X([1 4 7]),"B") "a2." + Unary_operator(X([3 6 9]))];
                    elseif (V(3)==0)
                        F = ["a0." + Unary_operator(X([1 4 7]),"B") "a1." + Unary_operator(X([2 5 8]))];
                    end
                else %there is no zero row
                    %there are two options for when there is no zero row
                    %vertical common signal F(1)
                    %or horizontal common signal F(2)
                    F = ["a0." + Unary_operator(X([1 4 7]),"B") "a1." + Unary_operator(X([2 5 8]),"B")  "a2." +  Unary_operator(X([3 6 9]),"B"); "b0." +  Unary_operator(X(1:3),"A")  "b1." + Unary_operator(X(4:6),"A")  "b2." +  Unary_operator(X(7:9),"A")];
        
                end
            end
        end
    end
    SOPs = F;
    return
end