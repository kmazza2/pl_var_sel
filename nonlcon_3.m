function [c, ceq] = nonlcon_3(param, data, t1, t2)
%NONLCON_3 Nonlinear constraint function for fmincon applied to (3)
gamma = param(1:data.p);
lambda = param((data.p + 1):(data.p + data.q));
c = (-1) * param;
ceq = [(sum(gamma) - t1) (sum(lambda) - t2)];
end

