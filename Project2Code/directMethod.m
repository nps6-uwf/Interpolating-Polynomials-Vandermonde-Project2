% Polynomial Approximation - Direct Method
% Author: Nick Sebasco
% Date: 07/09/2021

function poly = directMethod(points)
    % This function implements the direct method of creating an 
    % interpolating polynomial.  It returns a function handle that
    % takes a single argument x, and returns f(x).  Where f is the
    % interpolating polynomial.
    
    % >> Input (points) = Structure array of points from which to build the 
    % approximation function.
    % Example: points = struct('x', [0,1,2],'y', [2,3,5]);

    % 2) Build a vandermonder matrix from the x-values.
    VX = fliplr(vander(points.x)); % the fliplr function will reverse the order.

    % 3) Find interpolating polynomial coefficients
    Cn = VX\points.y.'; 
    % Alternative method of solving for coefficients:
    % Cn = linsolve(VX,points.y.') 
    
    % 4) Generate and return function handle that can evaluate the 
    % interpolating polynomial.
    poly = @(x) Polynomial(x, Cn);
end

function total = Polynomial(x, coeff)
    % This function takes two arguments:
    % 1) x, the x-coordinate at which to evaluate the polynomial
    % 2) the coefficients of the polynomial
    % This function returns p(x) of a polynomial evaluated at some x
    % for which it is defined.
    total = 0;
    for i=1:length(coeff)
        total = total + coeff(i).*x.^(i-1);
    end
end