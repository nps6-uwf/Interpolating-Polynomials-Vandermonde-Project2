% Numerical Analysis Project 2
% Author: Nick Sebasco
% Date: 07/09/2021

% In this project n = 5, 10, 15, 25, 35, n_t = 1000.
% All figures should include xlabel, ylablel, title, legend.
% All figures to be saved as fig or pdf files and zipped together.

% Version 2

% 0. Optionally clear stored stuff
clc; clear all;

% 1. Define actual functions & derivatives.
f = @(x) sin(x);      fp = @(x) cos(x);       % x in [0, 2pi]
g = @(x) sin(5*x);    gp = @(x) 5*cos(5*x);   % x in [0, 2pi]
h = @(x) 1./(1+x.^2); hp = @(x) -2./(1+x).^3; % x in [-5, 5]

% Style plot
% set(gca,'Color','k') % change plot background to black
set(gca,'Color',[1/17, 1/36, 1/36]) % cutom bg color.
set(gca,'fontname','Impact')        % use the 'Impact' font.

% 2. Generate test x-values given n = 5, 10, 15, 25, 35, 1000:
N = [5,10,15,25,35];
%N = [5,10]; % reassigning N to a subset of N.
nt = 1000; % number of test points

% Which function do we wish to approximate?
fString = "Sin(x)"; % options: "Sin(x)", Sin(5x), "1/(1+x)^2"

% Which approximation function do we wish to use?
aString = "direct"; % options: "direct", "lagrange", "hermite"

hold on;

% Set title and plot actual function:
if fString=="Sin(x)"
    a = 0; b = 2*pi;
    XT = linspace(a, b, nt);
    plot(XT, f(XT),'--')
    title(join([sprintf('Approximating %s with the %s Method on [0',fString,aString),', 2\pi]']))
elseif fString=="Sin(5x)"
    a = 0; b = 2*pi;
    XT = linspace(a, b, nt);
    plot(XT, g(XT),'--')
    title(join([sprintf('Approximating %s with the %s Method on [0',fString,aString),', 2\pi]']))
else
    a = -5; b = 5;
    XT = linspace(a, b, nt);
    plot(XT, h(XT),'--')
    title(sprintf('Approximating %s with the %s Method on -5 and 5',fString,aString))
end

% I use this arry of strings to build my legend
legendArray = {join(['{\color{gray}',fString,'}','{\color{white}Actual}'])};

for n=N
    legendArray{length(legendArray) + 1} = join(['{\color{white} ',sprintf('%s, n = %d}',aString,n)]);
    if fString=="Sin(x)" % Approximate sin(x).

        % 2a) Generate x & y values for each function.
        xfg = generateX(0, 2*pi, n); % domain for f & g.
        % 2b) Create the arguments for my directMethod function.
        yf =  f(xfg); % y-values for f.
        
        if aString=="direct" % Use the direct method.
            fpoints = struct('x',xfg,'y',yf);
            % 2c) Create the direct method polynomial function handles.
            fdirect = directMethod(fpoints);
            % 2d) Plot my approximations
            plot(XT, fdirect(XT))
        
        elseif aString=="lagrange"
            %P = lagrangepoly(xfg,yf);
            y1 = lagrangepoly(xfg,yf,XT);
            plot(XT, y1)
        
        elseif aString=="hermite"
            yfp = fp(xfg);
            [yhm,~,~] = Hermite(XT, xfg, yf, yfp);
            plot(XT, yhm)
        end
    elseif fString=="Sin(5x)" % Approximate sin(5x).
        xfg = generateX(0, 2*pi, n); % domain for f & g.
        yg = g(xfg);  % y-values for g.
        if aString=="direct"
            gpoints = struct('x',xfg,'y',yg);
            gdirect = directMethod(gpoints);
            plot(xfg, gdirect(xfg))
            
        elseif aString=="lagrange"
            %P = lagrangepoly(xfg,yf);
            y1 = lagrangepoly(xfg,yg,XT);
            plot(XT, y1)
            
        elseif aString=="hermite"
            ygp = gp(xfg);
            [yhm,~,~] = Hermite(XT, xfg, yg, ygp);
            plot(XT, yhm)
        end
    elseif fString=="1/(1+x)^2"
        xh = generateX(-5, 5, n); % domain for h.
        yh = h(xh);
        if aString=="direct"
            hpoints = struct('x',xh,'y',yh);
            hdirect = directMethod(hpoints);
            plot(xh, hdirect(xh))
            
        elseif aString=="lagrange"
            %P = lagrangepoly(xfg,yf);
            y1 = lagrangepoly(xh,yh,XT);
            plot(XT, y1)
            
        elseif aString=="hermite"
            yhp = fp(xh);
            [yhm,~,~] = Hermite(XT, xh, yh, yhp);
            plot(XT, yhm)
        end
    end
end


% Set final attributes of plots:
xlabel('x-axis')
ylabel('y-axis')
% legend(join(['{\color{gray}',fString,'}','{\color{white}Actual}']),'{\color{white}Direct n = 5}','{\color{white}Direct n = 10}','{\color{white}Direct n = 15}','{\color{white}Direct n = 25}','{\color{white}Direct n = 35}')
legend(legendArray)
axis tight;
%plot(x, fdirect(x))
%plot(x, g(x),"--");
%plot(x, h(x),"*-")
