function val = upper_s_lambda(Z, kernel, lambda)
%UPPER_S_LAMBDA Returns (uppercase) S_lambda(Z)

sz = size(Z);
num_params = sz(1);
num_obs = sz(2);

% preconditions:
assert(all(lambda >= 0));
assert(sz(1) == length(lambda));

% implementation:

val = zeros(num_obs, num_obs);

for i = 1:num_obs
    row = lower_s_lambda(uint64(i), Z, kernel, lambda);
    for j = 1:num_obs
        val(i, j) = row(j);
    end
end

% postconditions:
assert(all(size(val) == [num_obs num_obs]));

end

