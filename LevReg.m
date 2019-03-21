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
%%%%%%%%%%%%%% Leverage ratio regulation function %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Assetbt,BSCompbt,Liabbt,Portbt] = LevReg (b,nC,LR,Assetbt,BSCompbt,Liabbt,Portbt,Sdiff,Sdev,Fund)

while BSCompbt < LR
    
    shrink = BSCompbt/LR;
    Assnew = shrink*Assetbt;
    repay = Assetbt - Assnew;
    Assetbt = Assetbt - repay;
    Liabbt = Liabbt - repay;
    cash = Portbt(nC+1) - repay;
    
    if  cash > 0
        Portbt(nC+1) = cash;
    else
        if Fund(b) == 1
            [~,i] = sort(Sdev);  % Fund. base decision on deviations from F.
        else
            [~,i] = sort(Sdiff); % Chart. base decision on price changes.
        end
        sell = 1;
        while cash<0
            if Portbt(i(sell)) >= abs(cash)
                Portbt(i(sell)) = Portbt(i(sell)) - abs(cash);
                cash = 0;
            else
                cash = cash + Portbt(i(sell));
                Portbt(i(sell)) = 0;
            end
            sell = sell + 1;
        end
        Portbt(nC+1) = cash;
    end
    
    BSCompbt = 1 - (Liabbt/Assetbt);
    
end
