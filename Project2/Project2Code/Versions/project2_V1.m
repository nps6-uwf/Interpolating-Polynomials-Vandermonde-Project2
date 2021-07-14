% Numerical Analysis Project 2
% Author: Nick Sebasco
% Date: 07/09/2021

% In this project n = 5, 10, 15, 25, 35, n_t = 1000.
% All figures should include xlabel, ylablel, title, legend.
% All figures to be saved as fig or pdf files and zipped together.

% Version #1: This version only approximates the target functions using the 
% direct method.  Change the fString variable to approximate a specific 
% target function.

% 0. Optionally clear stored stuff
clc; clear all;

% 1. Define actual functions
f = @(x) sin(x);      % x in [0, 2pi]
g = @(x) sin(5*x);    % x in [0, 2pi]
h = @(x) 1./(1+x.^2); % x in [-5, 5]

% style plot
% set(gca,'Color','k') % change plot background to black
set(gca,'Color',[1/17, 1/36, 1/36]) % cutom bg color.
set(gca,'fontname','Impact')        % use the 'Impact' font.


% 2. Generate test x-values given n = 5, 10, 15, 25, 35, 1000:
N = [5,10,15,25,35,1000];

% Which function do we wish to approximate?
fString = "1/(1+x)^2"; % options: "Sin(x)", Sin(5x), "1/(1+x)^2"
hold on;
for n=N
    
    % 2a) Generate x & y values for each function.
    xfg = generateX(0, 2*pi, n); % domain for f & g.
    
    xh = generateX(-5, 5, n); % domain for h.
    yf =  f(xfg); % y-values for f.
    yg = g(xfg);  % y-values for g.
    yh = h(xh);
    
    % 2b) Create the arguments for my directMethod function.
    fpoints = struct('x',xfg,'y',yf);
    gpoints = struct('x',xfg,'y',yg);
    hpoints = struct('x',xh,'y',yh);
    
    % 2c) Create the direct method polynomial function handles.
    fdirect = directMethod(fpoints);
    gdirect = directMethod(gpoints);
    hdirect = directMethod(hpoints);
    
    if fString=="Sin(x)"
        plot(xfg, fdirect(xfg))
    elseif fString=="Sin(5x)"
        plot(xfg, gdirect(xfg))
    elseif fString=="1/(1+x)^2"
        plot(xh, hdirect(xh))
    end
    
end

% Set title and plot actual function:

if fString=="Sin(x)"
    plot(xfg, f(xfg))
    title(join([sprintf('Approximating %s with the Direct Method on [0',fString),', 2\pi]']))
elseif fString=="Sin(5x)"
    plot(xfg, g(xfg))
    title(join([sprintf('Approximating %s with the Direct Method on [0',fString),', 2\pi]']))
else
    plot(xh, h(xh))
    title(sprintf('Approximating %s with the Direct Method on -5 and 5',fString))
end

% Set final attributes of plots:
xlabel('x-axis')
ylabel('y-axis')
legend('{\color{white}Direct n = 5}','{\color{white}Direct n = 10}','{\color{white}Direct n = 15}','{\color{white}Direct n = 25}','{\color{white}Direct n = 35}','{\color{white}Direct n = 1000}',join(['{\color{gray}',fString,'}','{\color{white}Actual}']))
axis tight;
%plot(x, fdirect(x))
%plot(x, g(x),"--");
%plot(x, h(x),"*-")
