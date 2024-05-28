function val = tri_kern(x)
%TRI_KERN Tri-cube density kernel

val = 0.864197530864197 * (1 - abs(x)^3)^3 * (abs(x) <= 1);

end

