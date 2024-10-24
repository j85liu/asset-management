% Define inputs: Expected returns (in real terms), standard deviations, and correlation matrix
expected_returns = [0.0527; 0.0235; 0.0650; 0.0658; 0.0633; 0.0400; 0.0529; 0.0634];
stdDevs = [0.2100; 0.0349; 0.1804; 0.1791; 0.1918; 0.0767; 0.1441; 0.2061];
correlationMatrix = [
    1.0000  0.0914  0.3491  0.3593  0.3209  0.3582  0.3824  0.2955;
    0.0914  1.0000  0.1641  0.1618  0.1371  0.4074 -0.0117  0.1411;
    0.3491  0.1641  1.0000  0.5881  0.5160  0.5802  0.4957  0.4833;
    0.3593  0.1618  0.5881  1.0000  0.5300  0.5943  0.5137  0.4962;
    0.3209  0.1371  0.5160  0.5300  1.0000  0.5221  0.4740  0.4356;
    0.3582  0.4074  0.5802  0.5943  0.5221  1.0000  0.4904  0.4906;
    0.3824 -0.0117  0.4957  0.5137  0.4740  0.4904  1.0000  0.4219;
    0.2955  0.1411  0.4833  0.4962  0.4356  0.4906  0.4219  1.0000];

% Compute the covariance matrix from the standard deviations and correlation matrix
cov_matrix = diag(stdDevs) * correlationMatrix * diag(stdDevs);


risk_aversion = [3.5, 1.25, 4.5]; % Risk aversion values to test

% Optimization constraints: no short selling (non-negativity) and total weight = 1
nFunds = length(expected_returns);
Aeq = ones(1, nFunds);
beq = 1;
lb = zeros(nFunds, 1); % No short selling
ub = ones(nFunds, 1);  % No leveraging (weights can't exceed 100%)

% Optimal weights calculation for different risk aversion levels
for r = 1:length(risk_aversion)
    % Risk aversion coefficient for this iteration
    gamma = risk_aversion(r);
    
    % Minimize: w' * cov_matrix * w - 1/gamma * w' * expected_returns
    H = gamma * cov_matrix; % Part related to variance
    f = -expected_returns;  % Part related to expected returns
    
    % Quadratic programming to solve for weights
    opts = optimoptions('quadprog', 'Display', 'off');
    optimal_weights = quadprog(H, f, [], [], Aeq, beq, lb, ub, [], opts);
    
    % Optimal portfolio statistics
    port_return = optimal_weights' * expected_returns;
    port_sd = sqrt(optimal_weights' * cov_matrix * optimal_weights);
    
    % Sensitivity analysis: +/- 50% of individual weights
    x_range = -0.50:0.01:0.50; % +/- 50% deviation
    expected_returns_sensitivity = zeros(nFunds, length(x_range));
    sd_sensitivity = zeros(nFunds, length(x_range));
    
    for i = 1:nFunds
        for j = 1:length(x_range)
            % Adjust allocation of the ith fund by x%
            delta_allocation = optimal_weights(i) * x_range(j);
            adjusted_weights = optimal_weights;
            adjusted_weights(i) = optimal_weights(i) + delta_allocation;
            
            % Rebalance the other funds to maintain total weight = 1
            remaining_weight = 1 - adjusted_weights(i);
            total_other_weight = sum(optimal_weights) - optimal_weights(i);
            adjusted_weights(1:end ~= i) = optimal_weights(1:end ~= i) * (remaining_weight / total_other_weight);
            
            % Calculate portfolio expected return and standard deviation
            expected_returns_sensitivity(i, j) = adjusted_weights' * expected_returns;
            sd_sensitivity(i, j) = sqrt(adjusted_weights' * cov_matrix * adjusted_weights);
        end
    end
    
    % Plot sensitivity of portfolio expected return to deviations in allocation
    figure;
    hold on;
    for i = 1:nFunds
        plot(x_range * 100, expected_returns_sensitivity(i, :), 'DisplayName', sprintf('Fund %d', i));
    end
    xlabel('Deviation from Optimal Allocation (%)');
    ylabel('Portfolio Expected Return');
    legend({'BP', 'Income Fund', 'Fidelity Blue Chip Growth', 'Vanguard Growth & Income', 'Vanguard Windsor', 'Vanguard Wellesley Income', 'JP Morgan Trust International', 'Vanguard Small Cap Index'});
    title(sprintf('Portfolio Expected Return Sensitivity (Risk Aversion = %.2f)', gamma));
    hold off;
    
    % Plot sensitivity of portfolio standard deviation to deviations in allocation
    figure;
    hold on;
    for i = 1:nFunds
        plot(x_range * 100, sd_sensitivity(i, :), 'DisplayName', sprintf('Fund %d', i));
    end
    xlabel('Deviation from Optimal Allocation (%)');
    ylabel('Portfolio Standard Deviation');
    legend({'BP', 'Income Fund', 'Fidelity Blue Chip Growth', 'Vanguard Growth & Income', 'Vanguard Windsor', 'Vanguard Wellesley Income', 'JP Morgan Trust International', 'Vanguard Small Cap Index'});
    title(sprintf('Portfolio Standard Deviation Sensitivity (Risk Aversion = %.2f)', gamma));
    hold off;
end
