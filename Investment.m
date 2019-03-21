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
%%%%%%%%%%%%%%%%%%%%% Investment function %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Portbt = Investment (b,nC,Fund,Sdev,Sdiff,Assetbt,AssRec,Type,Portbt)

sell = 1;
buy = nC;

if Fund(b) == 1
    [~,i] = sort(Sdev);  % Fund. base decision on deviations from F.
else
    [~,i] = sort(Sdiff); % Chart. base decision on price changes.
end

ARb = AssRec(Type(b))*Assetbt;
Portbt(i(buy)) = Portbt(i(buy)) + abs(ARb);
while abs(ARb) > 1e-10
    if Portbt(i(sell)) >= ARb
        Portbt(i(sell)) = Portbt(i(sell)) - ARb;
        ARb = 0;
    else
        ARb = ARb - Portbt(i(sell));
        Portbt(i(sell)) = 0;
    end
    sell = sell + 1;
end

