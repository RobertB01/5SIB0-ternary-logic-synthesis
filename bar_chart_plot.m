close all; clear all; clc;
%results = TBDD, Geometric, quine-mcluskey, quine-mcluskey(proposed);
figure(1);
tiledlayout(1,2,"TileSpacing","compact","Padding","compact");
nexttile;
fontsize = 8;
results = [ 18, 23, 20, 10;
            18, 23, 21, 13;
            32, 32, 32, 28;
            24, 28, 18, 10;
            26, 31, 22, 12;
            24, 25, 25, 16;
            18, 23, 18, 6;

];

gate = categorical({'AND','OR','SUM','NCARRY','NANY','PRODUCT','CARRY'});
gate = reordercats(gate,{'AND','OR','SUM','NCARRY','NANY','PRODUCT','CARRY'});
HB = bar(gate, results, 'group');

leg = legend("TBDD","GEO","QM","QM (proposed)",'Location','northeast','Interpreter','latex');

a = (1:size(results,1)).';
x = [a-0.25 a-0.125 a+0.125 a+0.25];
for k=1:size(results,1)
    for m = 1:size(results,2)
        text(x(k,m),results(k,m),num2str(results(k,m)),'HorizontalAlignment','center','VerticalAlignment','bottom','Interpreter','latex','FontSize',fontsize);
    end
end
ylim([0 45]);
grid on;
ylabel("Amount of CNTFETs [-]",'Interpreter','latex');
set(gca,'ticklabelinterpreter','latex');
set(gca,'FontName','mwa_cmr10');

nexttile;
results = [50, 60, 49, 38;
            138, 151, 120, 88;
            42, 48, 43, 22;

];

gate = categorical({'Half adder','Full adder','Multiplier'});
gate = reordercats(gate,{'Half adder','Full adder','Multiplier'});
HB = bar(gate, results, 'group');
legend("TBDD","GEO","QM","QM (proposed)",'Location','northeast','Interpreter','latex');
a = (1:size(results,1)).';
x = [a-0.25 a-0.125 a+0.125 a+0.25];
for k=1:size(results,1)
    for m = 1:size(results,2)
        text(x(k,m),results(k,m),num2str(results(k,m)),'HorizontalAlignment','center','VerticalAlignment','bottom','Interpreter','latex','FontSize',fontsize);
    end
end
ylim([0 200]);

grid on;
ylabel("Amount of CNTFETs [-]",'Interpreter','latex');
set(gca,'ticklabelinterpreter','latex');
set(gca,'FontName','mwa_cmr10');
set(gcf, 'Units', 'centimeter', 'position', [4, 4, 21, 10]);
set(gcf,'renderer','Painters')