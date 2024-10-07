M = 3;
N = 5;

D1 = coarray(coprime(M,N));
table = tabulate(D1);
A = (DOF(D1)-1)/2;
a = find(table(:,1) == -A);
b = find(table(:,1) == A);
stem(table(:,1),table(:,2),"filled","LineWidth",2)
hold on
stem(table(a:b,1),table(a:b,2),"filled","-r","LineWidth",2)
xline(-M*N,"-","-MN","LineWidth",2);
xline(M*N,"-","MN","LineWidth",2);
grid
title("Weight function(DOF="+DOF(D1)+")")
xlabel("Difference coarray")
set(gca,"FontSize",16)

%calculate the physical array by M and N
function [S] = coprime(M,N)
    S = [];
    for i = 1:N
        if ismember((i-1)*M,S) == 0
            S = [S (i-1)*M];
        end
    end
    for i = 1:2*M
        if ismember((i-1)*N,S) == 0
            S = [S (i-1)*N];
        end
    end
    sort(S);
end

%calculate the difference coarray by the physical array
function [D] = coarray(S)
    D = [];
    for i = 1:length(S)
        for j = 1:length(S)
            D = [D S(i)-S(j)];
        end
    end
    D = sort(D);
end

%calculate the degree of freedom
function [output] = DOF(D)
    output = 0;
    for i = 1:max(D)
        if ismember(i,D)
            output = output + 1;
        else
            break
        end
    end
    output = 2*output + 1;
end