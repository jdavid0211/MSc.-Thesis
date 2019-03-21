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
%%%%%%%%%%% Initial portfolio compositions function %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function PortComp = PortComp(nB,nBBig,nBSma,BAll,BBInv,OIBig,nBC,AsCBig,SSInv,OISma,nSC,AsCSma,nC)

PortComp = zeros(nB,nC+1);

%For banks from big countries

BBe = BBInv(1) + (BBInv(2)-BBInv(1))*rand(nBBig,1);
OIBige = OIBig(1) + (OIBig(2)-OIBig(1))*rand(nBBig,1);
for bc = 1:nBBig
    A = rand(1,nBC);
    A(1,BAll(bc)) = 0;
    B = A./sum(A);
    PortComp(bc,1:nBC) = BBe(bc)*B;
    C = rand(1,nSC);
    D = C./sum(C);
    PortComp(bc,nBC+1:nBC+nSC) = (1-BBe(bc))*D;
    PortComp(bc,:) = (1-OIBige(bc))*PortComp(bc,:);
    PortComp(bc,BAll(bc)) = OIBige(bc);
    clear A B C D
end
clear BBe OIBige bc

%For banks from small countries

SSe = SSInv(1) + (SSInv(2)-SSInv(1))*rand(nBSma,1);
OISmae = OISma(1) + (OISma(2)-OISma(1))*rand(nBSma,1);
for sc = 1:nBSma
    A = rand(1,nBC);
    B = A./sum(A);
    PortComp(nBBig+sc,1:nBC) = (1-SSe(sc))*B;
    C = rand(1,nSC);
    C(1,BAll(nBBig+sc)-nBC) = 0;
    D = C./sum(C);
    PortComp(nBBig+sc,nBC+1:nBC+nSC) = SSe(sc)*D;
    PortComp(nBBig+sc,:) = (1-OISmae(sc))*PortComp(nBBig+sc,:);
    PortComp(nBBig+sc,BAll(nBBig+sc)) = OISmae(sc);
    clear A B C D
end
clear SSe OISmae sc

IAC(1:nBBig,1) = AsCBig(1) + (AsCBig(2)-AsCBig(1))*rand(nBBig,1);
IAC(nBBig+1:nBBig+nBSma,1) = AsCSma(1) + (AsCSma(2)-AsCSma(1))*rand(nBSma,1);

PortComp(:,1:nC) = IAC.*PortComp(:,1:nC);
PortComp(:,nC+1) = 1-IAC;

