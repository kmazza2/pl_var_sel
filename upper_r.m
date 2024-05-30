function val = upper_r(gamma, lambda, data)
%UPPER_R Referred to as R(gamma, lambda) in the paper
%   Makes use of the inversion identity on page 6 of the paper

X = data.Xs;
Y = data.Ys;
Z = data.Zs;

sz = size(X);
num_obs = sz(1);
num_params = sz(2);

% preconditions:
assert(num_params == length(gamma));



% implementation:

kern = @(x) gauss_kern(x);
I_n = eye(num_obs);
I_p = eye(num_params);
S_lambda = upper_s_lambda(Z, kern, lambda);
diag_sqrt_gamma = diag(sqrt(gamma));
I_minus_S = I_n - S_lambda;
val = (I_minus_S) * ...
    ( ...
        I_n - X * ...
        diag_sqrt_gamma * ...
            inv((1 / num_obs) * diag_sqrt_gamma * X' * (I_minus_S' * I_minus_S) * X * diag_sqrt_gamma + I_p) * ...
        diag_sqrt_gamma * ...
        ( ...
            (1 / num_obs) * X' * (I_minus_S' * I_minus_S) ...
        ) ...
     );

% postconditions:
assert(num_obs == length(val));

end

