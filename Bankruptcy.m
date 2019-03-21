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
%%%%%%%%%%%%%%%%%%%%% Bankruptcy function %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Portbt,Pnew,BRupt] = Bankruptcy (b,nC,nBank,All,Pnew,Portbt,LLR,BRupt)

if LLR == 1
    Pnew(nBank+All(b),1:nC) = Pnew(nBank+All(b),1:nC) + Portbt(1:nC);
    Pnew(nBank+All(b),nC+1) = Pnew(nBank+All(b),nC+1) - sum(Portbt(1:nC));
end

Portbt(nC+1) = Portbt(nC+1) + sum(Portbt(1:nC));
Portbt(1:nC) = 0;
BRupt(b) = 1;
    