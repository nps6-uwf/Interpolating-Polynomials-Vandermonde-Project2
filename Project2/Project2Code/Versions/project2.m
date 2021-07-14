% Numerical Analysis Project 2
% Author: Nick Sebasco
% Date: 07/09/2021

% In this project n = 5, 10, 15, 25, 35, n_t = 1000.
% All figures should include xlabel, ylablel, title, legend.
% All figures to be saved as fig or pdf files and zipped together.

% 0. Optionally clear stored stuff
% clc; clear all;

% 1. Define actual functions
f = @(x) sin(x);      % x in [0, 2pi]
g = @(x) sin(5*x);    % x in [0, 2pi]
h = @(x) 1./(1+x.^2); % x in [-5, 5]

% 2. Generate test x-values given n = 5, 10, 15, 25, 35, 1000:
for n=[1,3] %[5,10,15,25,35,1000]
    
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
    
    
end

% 3. Plot Actuals
hold on;

plot(x, f(x))
plot(x, fdirect(x))
%plot(x, g(x),"--");
%plot(x, h(x),"*-")
