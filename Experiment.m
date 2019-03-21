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
%%%%%%%%%%%%%%%%%%%%% Experiment function %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [BRupt,Asset,BSComp,Liab,Equi,S,alpha] = Experiment (nP,nC,nBC,nBank,mub,mus,sigmab,sigmas,Asset,PComp,Liab,Equi,BSComp,LR,LRReg,RAP,RAReg,pfund,AssRec,Type,All,LLR,BRupt)

% Initialize prices

S = zeros(nC,nP);            % Matrix of stock prices.
F = 100*ones(nC,nP);         % Matrix of fundamental prices.
mu = zeros(nC,1);            % Vector of drifts.
mu(1:nBC) = mub;
mu(nBC+1:nC) = mus;
sigma = rand(nC,1);          % Vector of volatilities.
sigma(1:nBC,1) = sigmab(1) + (sigmab(2)-sigmab(1))*sigma(1:nBC,1);
sigma(nBC+1:nC,1) = sigmas(1) + (sigmas(2)-sigmas(1))*sigma(nBC+1:nC,1);
r = sigma.*randn(nC,nP) + mu;% Matrix for price volatility ~N(mu,sigma).
alpha = zeros(nC,nP);        % Matrix of market effects.
Shock = zeros(nC,nP);        % Matrix of shocks.
Shock(1,1) = -2;             % Where and when to apply the shock.
Pnew = PComp;
Fund = rand(nBank,1) < pfund;

for t = 1:nP
    
    if t == 1
        
        S(:,1) = F(:,1).*(1 + r(:,1) + Shock(:,1).*sigma);   % Initial prices.
        Sdiff = (S(:,t) - F(:,t))./F(:,t);          % Price variations.
        Sdev = F(:,t) - S(:,t);                     % Deviation from fundamental price.
        
    else
        
        S(:,t) = S(:,t-1) + r(:,t).*S(:,t-1) + Shock(:,t).*sigma.*S(:,t-1) + (F(:,t-1)-S(:,t-1))*0.01 + alpha(:,t); % Prices given strategies.
        
        Sdiff = (S(:,t) - S(:,t-1))./S(:,t-1);  % Price variations.
        Sdev = F(:,t) - S(:,t);                 % Deviation from fundamental price.
        
    end
    
    PComp(:,1:nC) = Pnew(:,1:nC).*(1+Sdiff).';
    PComp(:,nC+1) = Pnew(:,nC+1);
    Asset(:,t) = sum(PComp(1:nBank,:),2);
    Equi(:,t) = Asset(:,t) - Liab(:,t);
    BSComp(:,t) = Equi(:,t)./Asset(:,t);
    Pnew = PComp;
    
    % Check for regulations
        
    for b = 1:nBank
        
        Assetbt = Asset(b,t);
        BSCompbt = BSComp(b,t);
        Liabbt = Liab(b,t);
        Equibt = Equi(b,t);
        Portbt = PComp(b,:);
        
        if Equibt > 0
            
            if LRReg(Type(b)) == 1
                [Assetbt,~,Liabbt,Portbt] = LevReg (b,nC,LR,Assetbt,BSCompbt,Liabbt,Portbt,Sdiff,Sdev,Fund);
            end
            
            if RAReg(Type(b)) == 1
                Portbt = RiskReg (b,nC,RAP,Equibt,Portbt,Sdiff,Sdev,Fund);
            end
            
            if Portbt == PComp(b,:)
                Portbt = Investment (b,nC,Fund,Sdev,Sdiff,Assetbt,AssRec,Type,Portbt);
            end
            
        else
            [Portbt,Pnew,BRupt] = Bankruptcy (b,nC,nBank,All,Pnew,Portbt,LLR,BRupt);
        end
        
        Pnew(b,:) = Portbt;
        Liab(b,t+1) = Liabbt;
    end
        
    % Strategies for next period
    if t<nP
        orders = Pnew(:,1:nC) - PComp(:,1:nC);
        tradebal = sum(orders);
        %tradetot = sum(abs(orders));
        cap = sum(PComp(:,1:nC));
        %traderat = tradebal./tradetot;
        traderat = tradebal./cap;
        traderat(isnan(traderat)) = 0;
        alpha(:,t+1) = sigma.*traderat'.*S(:,t);
    end
    
end
