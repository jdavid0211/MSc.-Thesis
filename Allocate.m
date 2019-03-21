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
%%%%%%%%%%%%%%%%%%%%% Allocation function %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [CBAll,SBAll] = Allocate (nBC,nSC,CBBig,CBSma,SBBig,SBSma)

BigC = [1:nBC];
SmaC = [nBC+1:nBC+nSC];

CBB = ones(1,CBBig);
CBS = ones(1,CBSma);

CBAll = [kron(BigC,CBB) kron(SmaC,CBS)].';

SBB = ones(1,SBBig);
SBS = ones(1,SBSma);

SBAll = [kron(BigC,SBB) kron(SmaC,SBS)].';
