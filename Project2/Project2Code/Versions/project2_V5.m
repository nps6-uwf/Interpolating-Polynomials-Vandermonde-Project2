% Numerical Analysis Project 2
% Author: Nick Sebasco
% Date: 07/09/2021

% In this project n = 5, 10, 15, 25, 35, n_t = 1000.
% All figures should include xlabel, ylablel, title, legend.
% All figures to be saved as fig or pdf files and zipped together.

% Version 5: 
%+Generates all 30 figures.
%-future improvements: improve performance by removing redundancies.

% 0. Optionally clear stored stuff
clc; clear all;

figureFileExtension = ".fig"; % jpg, fig ...
figureDirectory = 'P2Figures';

% Create new directory to store figures.
if ~exist(figureDirectory, 'dir')
       mkdir(figureDirectory)
else
    % wipe all preexitsing files from the figureDirectory
    delete(join([figureDirectory,'\*']));
end

% 1. Define actual functions & derivatives.
f = @(x) sin(x);      fp = @(x) cos(x);       % x in [0, 2pi]
g = @(x) sin(5*x);    gp = @(x) 5*cos(5*x);   % x in [0, 2pi]
h = @(x) 1./(1+x.^2); hp = @(x) -2./(1+x).^3; % x in [-5, 5]

% Style plot
% set(gca,'Color','k') % change plot background to black
% color = [17/255,36/255,36/255];
color = [1,1,1];

% 2. Generate test x-values given n = 5, 10, 15, 25, 35, 1000:
N = [5,10,15,25,35];
nt = 1000; % number of test points

for fString=["Sin(x)", "Sin(5x)", "1/(1+x)^2"]
    for n=N
        % Update color
        % color = color * 1.5; % update color for next batch
        if fString=="Sin(x)" % Approximate sin(x).

            % --
            a = 0; b = 2*pi;
            XT = linspace(a, b, nt);
            YT = f(XT);

            % 2a) Generate x & y values for each function.
            xfg = generateX(0, 2*pi, n); % domain for f & g.
            % 2b) Create the arguments for my directMethod function.
            yf =  f(xfg); % y-values for f.

            % Build plots required by Dr. Kuo
            % (A) Interpolation     
            yfp = fp(xfg);
            [yhm,~,~] = Hermite(XT, xfg, yf, yfp); % (A1) Hermite
            y1 = lagrangepoly(xfg,yf,XT);          % (A2) Lagrange

            % Plot Lagrange, Hermite, Direct, and Actual
            % Plot data
            figure(1)
            plot(XT,y1,'-b',XT,yhm,'--r',xfg,yf,'ok',XT,YT,'-k');

            % Style
            set(gca,'Color',color)       % cutom bg color. round(17/255,3), round(36/255,3), round(36/255,3); round((34+17)/2/255,3), round((72+36)/2/255,3), round((72+36)/2/255,3); round(34/255,3), round(72/255,3), round(72/255,3); round(68/255,3), round(148/255,3), round(148/255,3)
            set(gca,'fontname','Impact') % use the 'Impact' font.

            % Plot attributes
            title(join([sprintf('%s function, n = %d, ',fString, n),'with direct method, Lagrange, Hermite']))
            xlabel('x-axis')
            ylabel('y-axis')
            legend('Lagrange','Hermite','Direct','Actual')
            axis tight;

            % (B) Error
            figure(2);
            semilogy(XT, abs(YT-y1), '-b', XT, abs(YT-yhm));

            % Style
            set(gca,'Color',color)       % cutom bg color. round(17/255,3), round(36/255,3), round(36/255,3); round((34+17)/2/255,3), round((72+36)/2/255,3), round((72+36)/2/255,3); round(34/255,3), round(72/255,3), round(72/255,3); round(68/255,3), round(148/255,3), round(148/255,3)
            set(gca,'fontname','Impact') % use the 'Impact' font.

            % Error plot attributes
            title(join([sprintf('%s function absolute error, n = %d, ',fString, n),'with direct method, Lagrange, Hermite']))
            xlabel('x-axis')
            ylabel('Absolute error')
            legend('Lagrange','Hermite')
            axis tight;

            % Save figures in a subdirectory
            saveas(figure(1),[pwd,sprintf('%s/f_function_figure_%d%s',figureDirectory,n,figureFileExtension)]); 
            saveas(figure(2),[pwd,sprintf('%s/f_function_errorDistribution_figure_%d%s',figureDirectory,n,figureFileExtension)]);

        elseif fString=="Sin(5x)" % Approximate sin(5x).

            % --
            a = 0; b = 2*pi;
            XT = linspace(a, b, nt);
            YT = g(XT);

            % generate x & y values
            xfg = generateX(0, 2*pi, n); % domain for f & g.
            yg = g(xfg);  % y-values for g.

            ygp = gp(xfg);
            [yhm,~,~] = Hermite(XT, xfg, yg, ygp);
            y1 = lagrangepoly(xfg,yg,XT);

            % Plot Lagrange, Hermite, Direct, and Actual
            % Plot data
            figure(1)
            plot(XT,y1,'-b',XT,yhm,'--r',xfg,yg,'ok',XT,YT,'-k');

            % Style
            set(gca,'Color',color)       % cutom bg color. round(17/255,3), round(36/255,3), round(36/255,3); round((34+17)/2/255,3), round((72+36)/2/255,3), round((72+36)/2/255,3); round(34/255,3), round(72/255,3), round(72/255,3); round(68/255,3), round(148/255,3), round(148/255,3)
            set(gca,'fontname','Impact') % use the 'Impact' font.

            % Plot attributes
            title(join([sprintf('%s function, n = %d, ',fString, n),'with direct method, Lagrange, Hermite']))
            xlabel('x-axis')
            ylabel('y-axis')
            legend('Lagrange','Hermite','Direct','Actual')
            axis tight;

            % (B) Error
            figure(2);
            semilogy(XT, abs(YT-y1), '-b', XT, abs(YT-yhm));

            % Style
            set(gca,'Color',color)       % cutom bg color. round(17/255,3), round(36/255,3), round(36/255,3); round((34+17)/2/255,3), round((72+36)/2/255,3), round((72+36)/2/255,3); round(34/255,3), round(72/255,3), round(72/255,3); round(68/255,3), round(148/255,3), round(148/255,3)
            set(gca,'fontname','Impact') % use the 'Impact' font.

            % Error plot attributes
            title(join([sprintf('%s function absolute error, n = %d, ',fString, n),'with direct method, Lagrange, Hermite']))
            xlabel('x-axis')
            ylabel('Absolute error')
            legend('Lagrange','Hermite')
            axis tight;

            % Save figures in a subdirectory
            saveas(figure(1),[pwd,sprintf('%s/g_function_figure_%d%s',figureDirectory,n,figureFileExtension)]); 
            saveas(figure(2),[pwd,sprintf('%s/g_function_errorDistribution_figure_%d%s',figureDirectory,n,figureFileExtension)]);

        elseif fString=="1/(1+x)^2"

            % --
            a = -5; b = 5;
            XT = linspace(a, b, nt);
            YT = h(XT);


            % Generate the x & y 
            xh = generateX(-5, 5, n); % domain for h.
            yh = h(xh);

            y1 = lagrangepoly(xh,yh,XT);
            yhp = fp(xh);
            [yhm,~,~] = Hermite(XT, xh, yh, yhp);

            % Plot Lagrange, Hermite, Direct, and Actual
            % Plot data
            figure(1)
            plot(XT,y1,'-b',XT,yhm,'--r',xh,yh,'ok',XT,YT,'-k');

            % Style
            set(gca,'Color',color)       % cutom bg color. round(17/255,3), round(36/255,3), round(36/255,3); round((34+17)/2/255,3), round((72+36)/2/255,3), round((72+36)/2/255,3); round(34/255,3), round(72/255,3), round(72/255,3); round(68/255,3), round(148/255,3), round(148/255,3)
            set(gca,'fontname','Impact') % use the 'Impact' font.

            % Plot attributes
            title(join([sprintf('%s function, n = %d, ',fString, n),'with direct method, Lagrange, Hermite']))
            xlabel('x-axis')
            ylabel('y-axis')
            legend('Lagrange','Hermite','Direct','Actual')
            axis tight;

            % (B) Error
            figure(2);
            semilogy(XT, abs(YT-y1), '-b', XT, abs(YT-yhm));

            % Style
            set(gca,'Color',color)       % cutom bg color. round(17/255,3), round(36/255,3), round(36/255,3); round((34+17)/2/255,3), round((72+36)/2/255,3), round((72+36)/2/255,3); round(34/255,3), round(72/255,3), round(72/255,3); round(68/255,3), round(148/255,3), round(148/255,3)
            set(gca,'fontname','Impact') % use the 'Impact' font.

            % Error plot attributes
            title(join([sprintf('%s function absolute error, n = %d, ',fString, n),'with direct method, Lagrange, Hermite']))
            xlabel('x-axis')
            ylabel('Absolute error')
            legend('Lagrange','Hermite')
            axis tight;

            % Save figures in a subdirectory
            saveas(figure(1),[pwd,sprintf('%s/h_function_figure_%d%s',figureDirectory,n,figureFileExtension)]); 
            saveas(figure(2),[pwd,sprintf('%s/h_function_errorDistribution_figure_%d%s',figureDirectory,n,figureFileExtension)]);

        end
    end
end