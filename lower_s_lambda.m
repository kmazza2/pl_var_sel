function val = lower_s_lambda(i, Z, kernel, lambda)
%LOWER_S_LAMBDA Returns (lowercase) s_lambda(z_i)

sz = size(Z);
num_params = sz(1);
num_obs = sz(2);

% preconditions:
assert(isinteger(i) && 1 <= i && i <= num_obs);
assert(all(lambda >= 0));
assert(sz(1) == length(lambda));

% implementation:

z = Z(:,i);
scale = 0;
for i = 1:num_obs
    term = 1;
    for j = 1:num_params
        term = term * kernel(lambda(j) * (Z(j,i) - z(j)));
    end
    scale = scale + term;
end

vec = zeros(num_obs, 1);
for i = 1:num_obs
    vec(i) = 1;
    for j = 1:num_params
        vec(i) = vec(i) * kernel(lambda(j) * (Z(j,i) - z(j)));
    end
end


val = scale * vec;

% postconditions:
assert(length(val) == num_obs);

end

