classdef SimulationData
    %SIMULATIONDATA Simulation data per Example 6.1.
    
    properties (SetAccess = private)
        p
        q
        rho
        n
        response_func
        noise_std_dev
        % named "exes", "whys", and "zees" in 
        % the Haskell convention
        sigma
        Xs
        Ys
        Zs
    end
    
    methods
        function obj = SimulationData( ...
                p, q, rho, n, response_func, noise_std_dev)
            %SIMULATIONDATA
            % response_func must work on arrays of covariates
            % X and Z structured so that each column of
            % the covariate arrays is one sample covariate vector
            % (a column of X will contain all
            % the linear predictors for a single observation,
            % and a column of Z will contain all nonparametric
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
            raw_data = mvnrnd(mu, obj.sigma, obj.n)';
            obj.Xs = raw_data(1:obj.p, 1:obj.n);
            obj.Zs = 2 * normcdf( ...
                raw_data( ...
                    (obj.p + 1):(obj.p + obj.q), 1:obj.n) ...
                ) - 1;
            noise = mvnrnd( ...
                zeros(obj.n, 1), ...
                obj.noise_std_dev * eye(obj.n) ...
            )';
            obj.Ys = response_func(obj.Xs, obj.Zs) + noise;
        end
    end
end

