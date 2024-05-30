function [gamma, lambda] = optim_3(data, t1, t2, kern)
%OPTIM_3 Solve optimization problem (3) in the paper
get_gamma = @(param) param(1:data.p);
get_lambda = @(param) param((data.p + 1):(data.p + data.q));
fun = @(param) ...
    sq_resid( ...
        get_gamma(param), ...
        get_lambda(param), ...
        data, ...
        kern ...
    );
x0 = zeros(data.p + data.q, 1);
problem.objective = fun;
problem.x0 = x0;
problem.solver = 'fmincon';
problem.nonlcon = @(param) nonlcon_3(param, data, t1, t2);
problem.options = optimoptions('fmincon');
val = fmincon(problem);
gamma = get_gamma(val);
lambda = get_lambda(val);
end

