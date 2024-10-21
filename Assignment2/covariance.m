% MATLAB code to generate covariance matrix and plot risk vs. number of markets

% Set parameters for random data generation
num_assets = 5; % Number of markets/assets
num_data_points = 100; % Number of data points (e.g., daily returns)

% Generate random returns data (can be replaced with real data)
returns_data = randn(num_data_points, num_assets) * 0.01; % Simulate daily returns

% Calculate covariance matrix based on generated returns
cov_matrix = cov(returns_data);

% Display covariance matrix
disp('Covariance Matrix:');
disp(cov_matrix);

% Calculate expected returns for the assets (using the mean of returns)
expected_returns = mean(returns_data);

% Number of markets to evaluate (from 1 to the number of assets)
num_markets = num_assets;

% Risk aversion coefficient (for visualization, not used in equal-weight portfolio)
risk_aversion = 3.5;

% Initialize an array to store portfolio risk (standard deviation)
portfolio_risk = zeros(num_markets, 1);

% Loop through different numbers of markets to calculate risk
for i = 1:num_markets
    % Subset the covariance matrix and expected returns up to i markets
    sub_cov_matrix = cov_matrix(1:i, 1:i);
    sub_expected_returns = expected_returns(1:i);
    
    % Use equally weighted portfolio for simplicity
    weights = ones(i, 1) / i;
    
    % Calculate portfolio variance
    portfolio_variance = weights' * sub_cov_matrix * weights;
    
    % Calculate portfolio risk (standard deviation)
    portfolio_risk(i) = sqrt(portfolio_variance);
end

% Plot risk (standard deviation) vs. number of markets
figure;
plot(1:num_markets, portfolio_risk, '-o', 'LineWidth', 2);
xlabel('Number of Markets');
ylabel('Portfolio Risk (Standard Deviation)');
title('Portfolio Risk vs. Number of Markets');
grid on;

% Covariance Matrix Visualization (optional heatmap)
figure;
heatmap(cov_matrix, 'Colormap', parula, 'ColorbarVisible', 'on');
title('Covariance Matrix Heatmap');
xlabel('Assets');
ylabel('Assets');
