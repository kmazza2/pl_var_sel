function val = sq_resid(gamma, lambda, data, kern)
%SQ_RESID Objective function for problem (3) in the paper
y = data.Y;
R_times_y = upper_r(gamma, lambda, data, kern) * y;
val = R_times_y' * R_times_y;
end

