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
%%%%%%%%%%%%%%%%%%%%%%%%%%% Figures %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Baseline = readtable('Results.xlsx','Sheet','Baseline');
Shock1 = readtable('Results.xlsx','Sheet','Shock1');
Shock2 = readtable('Results.xlsx','Sheet','Shock2');
Shock3 = readtable('Results.xlsx','Sheet','Shock3');
ShockEM = readtable('Results.xlsx','Sheet','ShockEM');
ShockAllEM = readtable('Results.xlsx','Sheet','ShockAllEM');
BaselII = readtable('Results.xlsx','Sheet','BaselII');
RegSB = readtable('Results.xlsx','Sheet','RegSB');
NoLLR = readtable('Results.xlsx','Sheet','NoLLR');
AllChart = readtable('Results.xlsx','Sheet','AllChart');
AllFund = readtable('Results.xlsx','Sheet','AllFund');
RepInv = readtable('Results.xlsx','Sheet','RepInv');
RepInv2 = readtable('Results.xlsx','Sheet','RepInv2');
HighLev = readtable('Results.xlsx','Sheet','HighLev');

%% Figure 5.1 and A.1.1 %%

nEx = 20000;
MeanRes = zeros(nEx/100,3,5);
Var = zeros(nEx/100,5);

for v = 1:5
for e = 1:nEx/100

MeanRes(e,1,v) = mean(Baseline{1:e*100,v});
MeanRes(e,2,v) = abs(mean(Baseline{1:e*100,v}) - prctile(Baseline{1:e*100,v},5));
MeanRes(e,3,v) = abs(mean(Baseline{1:e*100,v}) - prctile(Baseline{1:e*100,v},95));

Var(e,v) = mean(Baseline{1:e*100,v});

end
end

figure;

subplot(2,1,1)
errorbar(100:100:nEx,MeanRes(:,1,1),MeanRes(:,2,1),MeanRes(:,3,1),'.','color',[0.8 0.8 0.8],'MarkerEdgeColor','r','MarkerSize',4)
ax = gca;
ax.XRuler.Exponent = 0;
xtickformat('%,.f')
ytickformat('%,.2f')
title('Probability of default under different number of simulations')
xlabel('N. of simulations')
ylabel('Probability of default')

subplot(2,1,2)
plot(100:100:nEx,Var(:,1),'r')
ax = gca;
ax.XRuler.Exponent = 0;
xtickformat('%,.f')
ytickformat('%,.3f')
title('Variance of the estimations')
xlabel('N. of simulations')
ylabel('Variance')

figure;
TG = 4;
EstTit = {'Est. Com. Banks DE' 'Est. Com. Banks EM' 'Est. Shad. Banks DE' 'Est. Shad. Banks EM'};
VarTit = {'Var. Com. Banks DE' 'Var. Com. Banks EM' 'Var. Shad. Banks DE' 'Var. Shad. Banks EM'};
for g = 1:TG
subplot(TG,2,2*g-1)
errorbar(100:100:nEx,MeanRes(:,1,g+1),MeanRes(:,2,g+1),MeanRes(:,3,g+1),'.','color',[0.8 0.8 0.8],'MarkerEdgeColor','r','MarkerSize',4)
ax = gca;
ax.XRuler.Exponent = 0;
xtickformat('%,.f')
title(EstTit(g))
xlabel('N. of simulations')
ylabel('Probability of default')

subplot(TG,2,2*g)
plot(100:100:nEx,Var(:,g+1),'r')
ax = gca;
ax.XRuler.Exponent = 0;
xtickformat('%,.f')
title(VarTit(g))
xlabel('N. of simulations')
ylabel('Variance')
end 

%% Figure 5.2 %%

nExp = 10000;
MeanRes = zeros(5,3);

for i = 1:5
    MeanRes(i,1) = mean(Baseline{1:nExp,i});
    MeanRes(i,2) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},5));
    MeanRes(i,3) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},95));
end

figure;
errorbar(1:5,MeanRes(:,1),MeanRes(:,2),MeanRes(:,3),'*','color',[0.5 0.5 0.5],'MarkerEdgeColor','r','MarkerSize',5)
xlim([0.5,5.5])
xticks([1 2 3 4 5])
xticklabels({'(a)','(b)','(c)','(d)','(e)'})
ylabel('Probability of default')

%% Figure 5.3 %%

nExp = 10000;
MeanRes = zeros(5,4,3);

for i = 1:5
    MeanRes(i,1,1) = mean(Baseline{1:nExp,i});
    MeanRes(i,1,2) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},5));
    MeanRes(i,1,3) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,2,1) = mean(Shock1{1:nExp,i});
    MeanRes(i,2,2) = abs(mean(Shock1{1:nExp,i}) - prctile(Shock1{1:nExp,i},5));
    MeanRes(i,2,3) = abs(mean(Shock1{1:nExp,i}) - prctile(Shock1{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,3,1) = mean(Shock2{1:nExp,i});
    MeanRes(i,3,2) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},5));
    MeanRes(i,3,3) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,4,1) = mean(Shock3{1:nExp,i});
    MeanRes(i,4,2) = abs(mean(Shock3{1:nExp,i}) - prctile(Shock3{1:nExp,i},5));
    MeanRes(i,4,3) = abs(mean(Shock3{1:nExp,i}) - prctile(Shock3{1:nExp,i},95));
end

figure;
EstTit = {'Average Estimation' 'Com. Banks DE' 'Com. Banks EM' 'Shad. Banks DE' 'Shad. Banks EM'};
for g = 1:5
subplot(1,5,g)
errorbar(0:3,MeanRes(g,:,1),MeanRes(g,:,2),MeanRes(g,:,3),'*','color',[0.5 0.5 0.5],'MarkerEdgeColor','r','MarkerSize',5)
xlim([-0.5,3.5])
xticks([0 1 2 3])
xticklabels({'(0)','(1)','(2)','(3)'})
ylabel('Probability of default')
title(EstTit(g))
end 

%% Figure 5.4 %%

nExp = 10000;
MeanRes = zeros(5,4,3);

for i = 1:5
    MeanRes(i,1,1) = mean(Baseline{1:nExp,i});
    MeanRes(i,1,2) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},5));
    MeanRes(i,1,3) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,2,1) = mean(Shock2{1:nExp,i});
    MeanRes(i,2,2) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},5));
    MeanRes(i,2,3) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,3,1) = mean(ShockEM{1:nExp,i});
    MeanRes(i,3,2) = abs(mean(ShockEM{1:nExp,i}) - prctile(ShockEM{1:nExp,i},5));
    MeanRes(i,3,3) = abs(mean(ShockEM{1:nExp,i}) - prctile(ShockEM{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,4,1) = mean(ShockAllEM{1:nExp,i});
    MeanRes(i,4,2) = abs(mean(ShockAllEM{1:nExp,i}) - prctile(ShockAllEM{1:nExp,i},5));
    MeanRes(i,4,3) = abs(mean(ShockAllEM{1:nExp,i}) - prctile(ShockAllEM{1:nExp,i},95));
end

figure;
EstTit = {'Average Estimation' 'Com. Banks DE' 'Com. Banks EM' 'Shad. Banks DE' 'Shad. Banks EM'};
for g = 1:5
subplot(1,5,g)
errorbar(1:4,MeanRes(g,:,1),MeanRes(g,:,2),MeanRes(g,:,3),'*','color',[0.5 0.5 0.5],'MarkerEdgeColor','r','MarkerSize',5)
xlim([0.5,4.5])
xticks([1 2 3 4])
xticklabels({'(a)','(b)','(c)','(d)'})
ylabel('Probability of default')
title(EstTit(g))
end 

%% Figure 5.5 %%

nExp = 10000;
MeanRes = zeros(5,3,3);

for i = 1:5
    MeanRes(i,1,1) = mean(Baseline{1:nExp,i});
    MeanRes(i,1,2) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},5));
    MeanRes(i,1,3) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,2,1) = mean(Shock2{1:nExp,i});
    MeanRes(i,2,2) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},5));
    MeanRes(i,2,3) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,3,1) = mean(BaselII{1:nExp,i});
    MeanRes(i,3,2) = abs(mean(BaselII{1:nExp,i}) - prctile(BaselII{1:nExp,i},5));
    MeanRes(i,3,3) = abs(mean(BaselII{1:nExp,i}) - prctile(BaselII{1:nExp,i},95));
end

figure;
EstTit = {'Average Estimation' 'Com. Banks DE' 'Com. Banks EM' 'Shad. Banks DE' 'Shad. Banks EM'};
for g = 1:5
subplot(1,5,g)
errorbar(1:3,MeanRes(g,:,1),MeanRes(g,:,2),MeanRes(g,:,3),'*','color',[0.5 0.5 0.5],'MarkerEdgeColor','r','MarkerSize',5)
xlim([0.5,3.5])
xticks([1 2 3])
xticklabels({'(a)','(b)','(c)'})
ylabel('Probability of default')
title(EstTit(g))
end 

%% Figure 5.6 %%

nExp = 10000;
MeanRes = zeros(5,3,3);

for i = 1:5
    MeanRes(i,1,1) = mean(Baseline{1:nExp,i});
    MeanRes(i,1,2) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},5));
    MeanRes(i,1,3) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,2,1) = mean(Shock2{1:nExp,i});
    MeanRes(i,2,2) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},5));
    MeanRes(i,2,3) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,3,1) = mean(RegSB{1:nExp,i});
    MeanRes(i,3,2) = abs(mean(RegSB{1:nExp,i}) - prctile(RegSB{1:nExp,i},5));
    MeanRes(i,3,3) = abs(mean(RegSB{1:nExp,i}) - prctile(RegSB{1:nExp,i},95));
end

figure;
EstTit = {'Average Estimation' 'Com. Banks DE' 'Com. Banks EM' 'Shad. Banks DE' 'Shad. Banks EM'};
for g = 1:5
subplot(1,5,g)
errorbar(1:3,MeanRes(g,:,1),MeanRes(g,:,2),MeanRes(g,:,3),'*','color',[0.5 0.5 0.5],'MarkerEdgeColor','r','MarkerSize',5)
xlim([0.5,3.5])
xticks([1 2 3])
xticklabels({'(a)','(b)','(c)'})
ylabel('Probability of default')
title(EstTit(g))
end 

%% Figure A.3.1 %%

nExp = 10000;
MeanRes = zeros(5,3,3);

for i = 1:5
    MeanRes(i,1,1) = mean(Baseline{1:nExp,i});
    MeanRes(i,1,2) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},5));
    MeanRes(i,1,3) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,2,1) = mean(Shock2{1:nExp,i});
    MeanRes(i,2,2) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},5));
    MeanRes(i,2,3) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,3,1) = mean(NoLLR{1:nExp,i});
    MeanRes(i,3,2) = abs(mean(NoLLR{1:nExp,i}) - prctile(NoLLR{1:nExp,i},5));
    MeanRes(i,3,3) = abs(mean(NoLLR{1:nExp,i}) - prctile(NoLLR{1:nExp,i},95));
end

figure;
EstTit = {'Average Estimation' 'Com. Banks DE' 'Com. Banks EM' 'Shad. Banks DE' 'Shad. Banks EM'};
for g = 1:5
subplot(1,5,g)
errorbar(1:3,MeanRes(g,:,1),MeanRes(g,:,2),MeanRes(g,:,3),'*','color',[0.5 0.5 0.5],'MarkerEdgeColor','r','MarkerSize',5)
xlim([0.5,3.5])
xticks([1 2 3])
xticklabels({'(a)','(b)','(c)'})
ylabel('Probability of default')
title(EstTit(g))
end 


%% Figure A.3.2 %%

nExp = 10000;
MeanRes = zeros(5,3,3);

for i = 1:5
    MeanRes(i,1,1) = mean(Baseline{1:nExp,i});
    MeanRes(i,1,2) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},5));
    MeanRes(i,1,3) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,2,1) = mean(Shock2{1:nExp,i});
    MeanRes(i,2,2) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},5));
    MeanRes(i,2,3) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,3,1) = mean(AllChart{1:nExp,i});
    MeanRes(i,3,2) = abs(mean(AllChart{1:nExp,i}) - prctile(AllChart{1:nExp,i},5));
    MeanRes(i,3,3) = abs(mean(AllChart{1:nExp,i}) - prctile(AllChart{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,4,1) = mean(AllFund{1:nExp,i});
    MeanRes(i,4,2) = abs(mean(AllFund{1:nExp,i}) - prctile(AllFund{1:nExp,i},5));
    MeanRes(i,4,3) = abs(mean(AllFund{1:nExp,i}) - prctile(AllFund{1:nExp,i},95));
end

figure;
EstTit = {'Average Estimation' 'Com. Banks DE' 'Com. Banks EM' 'Shad. Banks DE' 'Shad. Banks EM'};
for g = 1:5
subplot(1,5,g)
errorbar(1:4,MeanRes(g,:,1),MeanRes(g,:,2),MeanRes(g,:,3),'*','color',[0.5 0.5 0.5],'MarkerEdgeColor','r','MarkerSize',5)
xlim([0.5,4.5])
xticks([1 2 3 4])
xticklabels({'(a)','(b)','(c)','(d)'})
ylabel('Probability of default')
title(EstTit(g))
end 

%% Figure A.3.3 %%

nExp = 10000;
MeanRes = zeros(5,3,3);

for i = 1:5
    MeanRes(i,1,1) = mean(Baseline{1:nExp,i});
    MeanRes(i,1,2) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},5));
    MeanRes(i,1,3) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,2,1) = mean(Shock2{1:nExp,i});
    MeanRes(i,2,2) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},5));
    MeanRes(i,2,3) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,3,1) = mean(RepInv{1:nExp,i});
    MeanRes(i,3,2) = abs(mean(RepInv{1:nExp,i}) - prctile(RepInv{1:nExp,i},5));
    MeanRes(i,3,3) = abs(mean(RepInv{1:nExp,i}) - prctile(RepInv{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,4,1) = mean(RepInv2{1:nExp,i});
    MeanRes(i,4,2) = abs(mean(RepInv2{1:nExp,i}) - prctile(RepInv2{1:nExp,i},5));
    MeanRes(i,4,3) = abs(mean(RepInv2{1:nExp,i}) - prctile(RepInv2{1:nExp,i},95));
end

figure;
EstTit = {'Average Estimation' 'Com. Banks DE' 'Com. Banks EM' 'Shad. Banks DE' 'Shad. Banks EM'};
for g = 1:5
subplot(1,5,g)
errorbar(1:4,MeanRes(g,:,1),MeanRes(g,:,2),MeanRes(g,:,3),'*','color',[0.5 0.5 0.5],'MarkerEdgeColor','r','MarkerSize',5)
xlim([0.5,4.5])
xticks([1 2 3 4])
xticklabels({'(a)','(b)','(c)','(d)'})
ylabel('Probability of default')
title(EstTit(g))
end 

%% Figure A.3.4 %%

nExp = 10000;
MeanRes = zeros(5,3,3);

for i = 1:5
    MeanRes(i,1,1) = mean(Baseline{1:nExp,i});
    MeanRes(i,1,2) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},5));
    MeanRes(i,1,3) = abs(mean(Baseline{1:nExp,i}) - prctile(Baseline{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,2,1) = mean(Shock2{1:nExp,i});
    MeanRes(i,2,2) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},5));
    MeanRes(i,2,3) = abs(mean(Shock2{1:nExp,i}) - prctile(Shock2{1:nExp,i},95));
end

for i = 1:5
    MeanRes(i,3,1) = mean(HighLev{1:nExp,i});
    MeanRes(i,3,2) = abs(mean(HighLev{1:nExp,i}) - prctile(HighLev{1:nExp,i},5));
    MeanRes(i,3,3) = abs(mean(HighLev{1:nExp,i}) - prctile(HighLev{1:nExp,i},95));
end

figure;
EstTit = {'Average Estimation' 'Com. Banks DE' 'Com. Banks EM' 'Shad. Banks DE' 'Shad. Banks EM'};
for g = 1:5
subplot(1,5,g)
errorbar(1:3,MeanRes(g,:,1),MeanRes(g,:,2),MeanRes(g,:,3),'*','color',[0.5 0.5 0.5],'MarkerEdgeColor','r','MarkerSize',5)
xlim([0.5,3.5])
xticks([1 2 3])
xticklabels({'(a)','(b)','(c)'})
ylabel('Probability of default')
title(EstTit(g))
end 






