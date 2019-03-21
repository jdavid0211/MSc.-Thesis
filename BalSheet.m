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
%%%%%%%%%%%%%%% Initial Balance Sheets function %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Asset,BSComp,Liab,Equi] = BalSheet (nB,nBBig,nBSma,BBRat,SBRat,BSCBig,BSCSma)

Asset = zeros(nB,1);      % Assets of each agent through time.
BSComp = zeros(nB,1);     % Asset composition of each agent through time.
Liab = zeros(nB,1);       % Liabilities of each agent through time.
Equi = zeros(nB,1);       % Liabilities of each agent through time.

% Initial assets %

Asset(1,1) = 100;          % Reference economy.

%For banks from big countries
if nBBig > 1
    Asset(2:nBBig,1) = 100*(BBRat(1) + (BBRat(2)-BBRat(1))*rand(nBBig-1,1));
end
%For banks from small countries
Asset(nBBig+1:nBBig+nBSma,1) = 100*(SBRat(1) + (SBRat(2)-SBRat(1))*rand(nBSma,1));

% Balance Sheet composition %

BSComp(1:nBBig,1) = (BSCBig(1) + (BSCBig(2)-BSCBig(1))*rand(nBBig,1)); %For banks from big countries
BSComp(nBBig+1:nBBig+nBSma,1) = (BSCSma(1) + (BSCSma(2)-BSCSma(1))*rand(nBSma,1)); %For banks from small countries

% Initial liabilities %

Liab(:,1) = Asset(:,1).*(1-BSComp(:,1));

%Initial Equity

Equi(:,1) = Asset(:,1) - Liab(:,1);


