function createfigure(XMatrix1, Y1)
%CREATEFIGURE(XMatrix1, Y1)
%  XMATRIX1:  matrix of plot x data
%  Y1:  vector of plot y data

%  Auto-generated by MATLAB on 01-Jan-2023 19:59:49

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple line objects using matrix input to plot
plot1 = plot(XMatrix1,Y1,'LineWidth',3,'Parent',axes1);
set(plot1(1),'DisplayName','CON','Color',[0 0 0]);
set(plot1(2),'DisplayName','CON-I','Color',[0 1 0]);
set(plot1(3),'DisplayName','CON-II','Color',[1 0 0]);
set(plot1(4),'DisplayName','CUM','Color',[1 0 1]);
set(plot1(5),'DisplayName','FML','Color',[0 0 1]);
set(plot1(6),'DisplayName','FMLM',...
    'Color',[0.717647058823529 0.274509803921569 1]);
set(plot1(7),'DisplayName','CHLM',...
    'Color',[0.850980392156863 0.325490196078431 0.0980392156862745]);
set(plot1(8),'DisplayName','CLS','MarkerSize',4,...
    'Color',[0.635294117647059 0.0784313725490196 0.184313725490196]);

% Create ylabel
ylabel('Long Term RMSE (meters)','FontWeight','bold');

% Create xlabel
xlabel('Error Distance (m)','FontWeight','bold');

box(axes1,'on');
grid(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontSize',18,'FontWeight','bold','GridAlpha',0.3,'XMinorGrid',...
    'on','YMinorGrid','on');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.696428571428571 0.154761904761906 0.190178571428571 0.475],...
    'FontSize',20);
