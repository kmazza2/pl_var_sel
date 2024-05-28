function val = epan_kern(x)
%EPAN_KERN Epanechnikov density kernel

val = 0.75 * (1 - x^2) * (abs(x) <= 1);

end

