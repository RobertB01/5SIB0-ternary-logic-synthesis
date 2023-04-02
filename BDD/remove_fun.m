function list = remove_fun(listnew)
    % remove duplicate functions and merge respective nodes in BDD
    %disp(length(listnew))
    disp(listnew)
    %disp("old length:" +  length(listnew))
    for i=1:length(listnew)
        if (i>length(listnew))
            break
        end
        for j =1:length(listnew)
            if(i~=j & isSame(listnew{j}, listnew{i}))
                disp("list " + i + "and list " + j + " are the same");
                i = 1;
                listnew(i)= [];
                break;
            end
        end
    end
    %disp("new length:" + length(listnew))
    list = listnew;
end

function outcome = isSame(list1, list2)
    outcome = 0;
    if(length(list1) == length(list2))
            if(list1 == list2)
                outcome = 1;
            end
    end
end