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
%%%%%%%%%%%%%%%%% Results compilation function %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ResTot,ResType] = Results (nCBBig,nCBSma,nSBBig,nSBSma,nCBank,BRupt)

ResTot = mean(BRupt);

ResType = zeros(4,1);
ResType(1,1) = mean(BRupt(1:nCBBig));
ResType(2,1) = mean(BRupt(nCBBig+1:nCBBig+nCBSma));
ResType(3,1) = mean(BRupt(nCBank+1:nCBank+nSBBig));
ResType(4,1) = mean(BRupt(nCBank+nSBBig+1:nCBank+nSBBig+nSBSma));
