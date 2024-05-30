classdef SimulationData
    %SIMULATIONDATA Simulation data per Example 6.1.
    
    properties (SetAccess = private)
        p
        q
        rho
        n
        response_func
        noise_std_dev
        sigma
        X
        Y
        Z
    end
    
    methods
        function obj = SimulationData( ...
                p, q, rho, n, response_func, noise_std_dev)
            %SIMULATIONDATA
            % response_func must work on arrays of covariates
            % X and Z structured so that each row of
            % the covariate arrays is one sample covariate vector
            % (a row of X will contain all
            % the linear predictors for a single observation,
            % and a row of Z will contain all nonparametric
            % predictors for a single observation
            assert(isinteger(p) && p > 0);
            assert(isinteger(q) && q > 0);
            assert(isinteger(n) && n > 0);
            assert(noise_std_dev >= 0);
            obj.p = double(p);
            obj.q = double(q);
            obj.rho = rho;
            obj.n = n;
            obj.response_func = response_func;
            obj.noise_std_dev = noise_std_dev;
            mu = zeros(obj.p + obj.q, 1);
            obj.sigma = rho .^ ...
                abs( ...
                    repmat( ...
                        1:(obj.p + obj.q), ...
                        obj.p + obj.q, ...
                        1)' - ...
                    repmat( ...
                        1:(obj.p + obj.q), ...
                        obj.p + obj.q, ...
                        1) ...
                );
            raw_data = mvnrnd(mu, obj.sigma, obj.n);
            obj.X = raw_data(1:obj.n, 1:obj.p);
            obj.Z = 2 * normcdf( ...
                raw_data( ...
                    1:obj.n, (obj.p + 1):(obj.p + obj.q)) ...
                ) - 1;
            noise = mvnrnd( ...
                zeros(obj.n, 1), ...
                obj.noise_std_dev * eye(obj.n) ...
            )';
            obj.Y = response_func(obj.X, obj.Z) + noise;
        end
    end
end

