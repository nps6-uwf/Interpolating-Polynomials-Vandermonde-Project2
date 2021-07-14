% Genrates a a sequence of points defined by the following:
% xi = a + [b-a]*1/n; i = 0, 1, 2, ..., n
% Author: Nick Sebasco
% Date: 07/09/2021

function X = generateX(a, b, n)
    % a = start interval
    % b = end interval
    % n = # points
    X = zeros(1,n);
    for i=0:n
        X(i+1) = a + (b-a)*i/n;
    end
end