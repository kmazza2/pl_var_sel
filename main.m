p = uint64(5);
q = uint64(3);
rho = 0.5;
n = uint64(100);
response_func = @(X, Z) ...
    ( ...
        X(2,:) + X(4,:) + ...
        sqrt(2) * sin(pi * Z(1,:)) ...
    )';
noise_std_dev = 1;
data = ...
    SimulationData( ...
        p, ...
        q, ...
        rho, ...
        n, ...
        response_func, ...
        noise_std_dev ...
    );