function val = boxcar_kern(x)
%BOXCAR_KERN Boxcar density kernel

val = 0.5 * (abs(x) <= 1);

end

