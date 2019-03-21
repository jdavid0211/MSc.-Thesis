%%%%%%%%%%%%%%%%%%%% UNIVERSITY OF GENEVA  %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%Geneva School of Economics and Management%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% MSc. in Economics %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%  MASTER THESIS  %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% We are bulletproof: %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Banking regulation and crisis contagion %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% in developing countries %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Author: Juan David Vega Baquero %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% January 2019 %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Risk adjusted regulation function %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Portbt = RiskReg (b,nC,RAP,Equibt,Portbt,Sdiff,Sdev,Fund)

if Fund(b) == 1
    [~,i] = sort(Sdev);  % Fund. base decision on deviations from F.
else
    [~,i] = sort(Sdiff); % Chart. base decision on price changes.
end
sell = 1;
miss = Equibt - RAP*sum(Portbt(1:nC));

if miss < 0
    while abs(miss) > 1e-10
        if Portbt(i(sell)) > abs(miss)
            Portbt(nC+1) = Portbt(nC+1) + abs(miss);
            Portbt(i(sell)) = Portbt(i(sell)) - abs(miss);
            miss = Equibt - RAP*sum(Portbt(1:nC));
        else
            Portbt(nC+1) = Portbt(nC+1) + Portbt(i(sell));
            Portbt(i(sell)) = 0;
            miss = Equibt - RAP*sum(Portbt(1:nC));
            sell = sell + 1;
        end
    end
end

