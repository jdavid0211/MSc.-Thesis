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
%%%%%%%%%%%%%%%%%%%%%%%%%% MAIN CODE %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameters

nBC = 02;                    % Number of big countries.
nSC = 03;                    % Number of small countries. 
nC = nBC + nSC;              % Total number of countries. 
CBBig = 20;                  % Number of commercial banks from each big country.
CBSma = 10;                  % Number of commercial banks from each small country.
SBBig = 09;                  % Number of shadow banks from each big country.
SBSma = 04;                  % Number of shadow banks from each small country.
nCBBig = nBC*CBBig;          % Number of commercial banks from big countries. 
nSBBig = nBC*SBBig;          % Number of shadow banks from big countries.
nCBSma = nSC*CBSma;          % Number of commercial banks from small countries. 
nSBSma = nSC*SBSma;          % Number of shadow banks from small countries.
nCBank = nCBBig + nCBSma;    % Total number of commercial banks. 
nSBank = nSBBig + nSBSma;    % Total number of shadow banks. 
nBank = nCBank + nSBank;     % Total number of banks. 

BBRat = [0.1 3.0];           % Big-Big ratio (%Big/Big).
SBRat = [0.05 1.5];          % Small-Big ratio (%Small/Big).
AsCBig = [0.3 0.9];          % Asset composition of Big country (%R).
AsCSma = [0.3 0.9];          % Asset composition of Small country (%R).
OIBig = [0.2 0.8];           % Own investment of Big in risky assets. 
OISma = [0.1 0.7];           % Own investment of Small in risky assets.
BBInv = [0.7 1.0];           % Big-Big investment in risky assets (%B). 
SSInv = [0.0 0.8];           % Small-Small investment in risky assets (%S).
BSCBig = [0.01 0.13];        % Balance sheet leverage of Big country (%E).
BSCSma = [0.05 0.24];        % Balance sheet leverage of Small country (%E).

mub = 0;                     % Drift for the returns for big countries.
mus = 0;                     % Drift for the returns for small countries.
sigmab = [0.00 0.01];        % Market volatility in big countries.
sigmas = [0.00 0.03];        % Market volatility in small countries.
nP = 100;                    % Number of periods. 
nExp = 10000;                % Number of experiments. 
LR = 0.03;                   % Leverage ratio regulation.
LRReg = [1 0];               % Leverage ratio regulation applied [CB SB].
RAP = 0.06;                  % Risk adjusted regulation. 
RAReg = [1 0];               % Risk adjusted regulation applied [CB SB].
LLR = 1;                     % Existence of a lender of last resort. 
pfund = 0.50;                % Probability of being a fundamentalist. 
AssRec = [0.01 0.01];        % Shift between risky assets for each type. 

%% Experiments

ResTot = zeros(1,nExp);
ResType = zeros(4,nExp);

% Assignation of banks into countries.
[CBAll,SBAll] = Allocate (nBC,nSC,CBBig,CBSma,SBBig,SBSma);
All = [CBAll ; SBAll];
Type(1:nCBank,1) = 1;
Type(nCBank+1:nBank,1) = 2;

for e = 1:nExp
    
    %Initial setting%
    rng(53*e);
    Asset = zeros(nBank,nP);      % Assets of each agent through time.
    BSComp = zeros(nBank,nP);     % Asset composition of each agent through time.
    Liab = zeros(nBank,nP);       % Liabilities of each agent through time.
    Equi = zeros(nBank,nP);       % Liabilities of each agent through time.
    PComp = zeros(nBank,nC+1);    % Portfolio composition for each bank.
    BRupt = zeros(nBank,1);       % Banks in Bankruptcy at the end of the experiment.
    
    [Asset(1:nCBank,1),BSComp(1:nCBank,1),Liab(1:nCBank,1),Equi(1:nCBank,1)] = ...
        BalSheet (nCBank,nCBBig,nCBSma,BBRat,SBRat,BSCBig,BSCSma);
    [Asset(nCBank+1:nBank,1),BSComp(nCBank+1:nBank,1),Liab(nCBank+1:nBank,1),Equi(nCBank+1:nBank,1)] = ...
        BalSheet (nSBank,nSBBig,nSBSma,BBRat,SBRat,BSCBig,BSCSma);
    
    PComp(1:nCBank,:) = PortComp (nCBank,nCBBig,nCBSma,CBAll,BBInv,OIBig,nBC,AsCBig,SSInv,OISma,nSC,AsCSma,nC);
    PComp(nCBank+1:nBank,:) = PortComp (nSBank,nSBBig,nSBSma,SBAll,BBInv,OIBig,nBC,AsCBig,SSInv,OISma,nSC,AsCSma,nC);
    PComp = Asset(:,1).*PComp(1:nBank,:);
    
    if LLR == 1                       % Include Lender of Last Resort.
        PComp(nBank+1:nBank+nC,:) = zeros(nC,nC+1);
        PComp(nBank+1:nBank+nC,nC+1) = 1e+10;
    end
    
    rng(97*e);
    [BRupt,Asset,BSComp,Liab,Equi,S,alpha] = Experiment (nP,nC,nBC,nBank,mub,mus,sigmab,sigmas,Asset,PComp,Liab,Equi,BSComp,LR,LRReg,RAP,RAReg,pfund,AssRec,Type,All,LLR,BRupt);
    [ResTot(:,e),ResType(:,e)] = Results (nCBBig,nCBSma,nSBBig,nSBSma,nCBank,BRupt);
    
end

%% Store Baseline Results

Baseline = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(Baseline,'Results.xlsx','Sheet','Baseline');

%% Store Results for Shock = sigma

Shock1 = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(Shock1,'Results.xlsx','Sheet','Shock1');

%% Store Results for Shock = 2*sigma

Shock2 = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(Shock2,'Results.xlsx','Sheet','Shock2');

%% Store Results for Shock = 3*sigma

Shock3 = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(Shock3,'Results.xlsx','Sheet','Shock3');

%% Store Results for Shock in EM

ShockEM = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(ShockEM,'Results.xlsx','Sheet','ShockEM');

%% Store Results for Shock in all EM

ShockAllEM = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(ShockAllEM,'Results.xlsx','Sheet','ShockAllEM');

%% Store Results under Basel II

BaselII = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(BaselII,'Results.xlsx','Sheet','BaselII');

%% Store Results for regulated shadow banks 

RegSB = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(RegSB,'Results.xlsx','Sheet','RegSB');

%% Store Results for No LLR 

NoLLR = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(NoLLR,'Results.xlsx','Sheet','NoLLR');

%% Store Results for All Chartists 

AllChart = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(AllChart,'Results.xlsx','Sheet','AllChart');

%% Store Results for All Fundamentalists 

AllFund = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(AllFund,'Results.xlsx','Sheet','AllFund');

%% Store Results for Representative Investor (shock on DE)

RepInv = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(RepInv,'Results.xlsx','Sheet','RepInv');

%% Store Results for Representative Investor (shock on EM)

RepInv2 = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(RepInv2,'Results.xlsx','Sheet','RepInv2');

%% Store Results for Higher Leverage

HighLev = table(ResTot',ResType(1,:)',ResType(2,:)',ResType(3,:)',ResType(4,:)',...
    'VariableNames',{'Average','CB_BC','CB_SC','SB_BC','SB_SC'});

writetable(HighLev,'Results.xlsx','Sheet','HighLev');





