%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% Ternary logic synthesis %%%%%%%%%%%%%%%%
%%%%%%%% 5SIB0 - Electronic Design Automation %%%%%%%%
%%%%%%%%%%%%%%%%%%% Group 4 %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Imp_mrg, PrImp] = MergeGroups(Imp, Opt)
    % (for all imp_i,imp_j in Imp do)
    k = 1;
    l = 1;
    Imp_mrg(1,1) = convertCharsToStrings('');
    Merged_imp(1,1) = convertCharsToStrings('');
    for i = 1:length(Imp(:,1))
        if Imp(i,1) ~= ""
            x_i     = str2double(extract(Imp(i,2),2));
            y_i     = str2double(extract(Imp(i,2),4));
            a_i     = str2double(extract(Imp(i,1),2));
            b_i     = str2double(extract(Imp(i,1),4));
        end
        for j = 1:length(Imp(:,1)) 
            if Imp(j,1) ~= ""
                % (if adj(g_i,g_j) and one_trit_diff(imp_i,imp_j) then)
                x_j     = str2double(extract(Imp(j,2),2));
                y_j     = str2double(extract(Imp(j,2),4));
                a_j     = str2double(extract(Imp(j,1),2));
                b_j     = str2double(extract(Imp(j,1),4));
                if (((x_i == x_j)||(x_i == x_j+1)||(x_i == x_j-1))&&((y_i == y_j)||(y_i == y_j+1)||(y_i == y_j-1)))
                    if (a_i == a_j) && (b_i ~= b_j)
                        % (Imp_mrg <- Imp_mrg union merge(imp_i,imp_j))
                        mrg = convertCharsToStrings(['A',num2str(a_i),'(B',num2str(min(b_i,b_j)),'+B',num2str(max(b_i,b_j)),')']);
                        if sum(matches(Imp_mrg,mrg)) == 0
                            Imp_mrg(k,1) = mrg;
                            Imp_mrg(k,2) = convertCharsToStrings(['[',num2str(count(Imp_mrg(k,1),"1")),',',num2str(count(Imp_mrg(k,1),"2")),']']);
                            Imp_mrg(k,3) = Imp(i,1);
                            Imp_mrg(k,4) = Imp(j,1);
                            k = k+1;
                            if sum(matches(Merged_imp,Imp(i,1))) == 0
                                Merged_imp(l,1) = Imp(i,1);
                                l = l+1;
                            end
                            if sum(matches(Merged_imp,Imp(j,1))) == 0
                                Merged_imp(l,1) = Imp(j,1);
                                l = l+1;
                            end
                        end
                    elseif (b_i == b_j) && (a_i ~= a_j)
                        mrg = convertCharsToStrings(['(A',num2str(min(a_i,a_j)),'+A',num2str(max(a_i,a_j)),')B',num2str(b_i)]);
                        if sum(matches(Imp_mrg,mrg)) == 0
                            Imp_mrg(k,1) = mrg;
                            Imp_mrg(k,2) = convertCharsToStrings(['[',num2str(count(Imp_mrg(k,1),"1")),',',num2str(count(Imp_mrg(k,1),"2")),']']);
                            Imp_mrg(k,3) = Imp(i,1);
                            Imp_mrg(k,4) = Imp(j,1);
                            k = k+1;
                        end
                        if sum(matches(Merged_imp,Imp(i,1))) == 0
                            Merged_imp(l,1) = Imp(i,1);
                            l = l+1;
                        end
                        if sum(matches(Merged_imp,Imp(j,1))) == 0
                            Merged_imp(l,1) = Imp(j,1);
                            l = l+1;
                        end
                    end
                end

            % (end if)
            end
        % (end for)
        end
    end
    %  (for all unmergeable imp_i in Imp do)
        % (PrImp <- PrImp uniun {imp_i})
    PrImp = Imp(~matches(Imp(:,1),Merged_imp(:,1)));
    % (end for)
    if Opt == "TRUE"
        if Imp_mrg(1,1) ~= ""
            for i = 1:length(Imp_mrg(:,1))
                if i <= length(Imp_mrg(:,1))
                    x_i     = str2double(extract(Imp_mrg(i,2),2));
                    y_i     = str2double(extract(Imp_mrg(i,2),4));
                    a_i     = str2double(extract(Imp_mrg(i,3),2));
                    b_i     = str2double(extract(Imp_mrg(i,3),4));
                    c_i     = str2double(extract(Imp_mrg(i,4),2));
                    d_i     = str2double(extract(Imp_mrg(i,4),4));
                end
                for j = 1:length(Imp_mrg(:,1))
                    if j <= length(Imp_mrg(:,1))
                        x_j     = str2double(extract(Imp_mrg(j,2),2));
                        y_j     = str2double(extract(Imp_mrg(j,2),4));
                        a_j     = str2double(extract(Imp_mrg(j,3),2));
                        b_j     = str2double(extract(Imp_mrg(j,3),4));
                        c_j     = str2double(extract(Imp_mrg(j,4),2));
                        d_j     = str2double(extract(Imp_mrg(j,4),4));
                    end
                    if (((x_i == x_j)||(x_i == x_j+1)||(x_i == x_j-1))&&((y_i == y_j)||(y_i == y_j+1)||(y_i == y_j-1)))
                        if xor(((a_i == a_j) && ((b_i == b_j)||(b_i == d_i))),((b_i == b_j) && ((a_i == a_j)||(a_i == c_i))))
                            mrg = convertCharsToStrings(['(A',num2str(min(a_i,a_j)),'+A',num2str(max(c_i,c_j)),')(B',num2str(min(b_i,b_j)),'+B',num2str(max(d_i,d_j)),')']);
                            if sum(matches(Imp_mrg,mrg)) == 0
                                Imp_mrg(k,1) = mrg;
                                Imp_mrg(k,2) = convertCharsToStrings(['[',num2str(count(Imp_mrg(k,1),"1")),',',num2str(count(Imp_mrg(k,1),"2")),']']);
                                Imp_mrg(k,3) = convertCharsToStrings(['A',num2str(min([a_i,a_j,c_i,c_j])),'B',num2str(min([b_i,b_j,d_i,d_j]))]);
                                Imp_mrg(k,4) = convertCharsToStrings(['A',num2str(min([a_i,a_j,c_i,c_j])),'B',num2str(max([b_i,b_j,d_i,d_j]))]);
                                Imp_mrg(k,5) = convertCharsToStrings(['A',num2str(max([a_i,a_j,c_i,c_j])),'B',num2str(min([b_i,b_j,d_i,d_j]))]);
                                Imp_mrg(k,6) = convertCharsToStrings(['A',num2str(max([a_i,a_j,c_i,c_j])),'B',num2str(max([b_i,b_j,d_i,d_j]))]);
                                k = k+1;
                            end
                        end
                    else
                        Imp_mrg = Imp_mrg;
                    end
                end
            end
        end
    end
end