

There are 2 directories.  In my code there is a boolean variable, useVandermondeDirect.  If this is set to true.
the "Figures1_directMethod" are created.  If it is false, the "Figures2_plotDataPointsDirect".  The difference stems
from how the direct method is implemented.

1. Figures1_directMethod
- The direct method here is computed according to the function I wrote, "directMethod.m".  The vandermonde matrix is solved
  for the coeffiecients of the interpolating polynomial.  In the error distribution graphs, the direct method error will be shown.

2. Figures2_plotDataPointsDirect
- The direct method here is computed by simply "plotting" the data points as suggested by Dr. Kuo.  
  The sample x values are generated: xi = a + [b-a]*1/n; i = 0, 1, 2, ..., n; then the data points are built:
  (xi, f(xi)),... .  Then these points are just simply plotted, we let Matlab do the interpolation.  There are
  no error graphs for the direct method this way.
  