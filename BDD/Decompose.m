%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function O_small = Decompose(O, column, i)
    if(height(O) < 4)
        warning("You cannot decompose a unary operator");
    end

    % Give the truth tables when var is set to 0,1,2
    O_small = O;
    %remove_rows = zeros(1,height(O)-height(O)/3); % amount of rows to delete

    O_column = O_small(:,column); %column belonging to variable
    idx = any((O_column ~= i),2);
    % store deleted rows
    m_toDelete = O_small(idx,:);
    % delete rows
    O_small(idx,:) = [];

    % remove column belonging to variable
    O_small(:,column) = [];
end
