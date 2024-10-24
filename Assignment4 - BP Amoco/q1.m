% Define inputs: Expected returns, standard deviations, and correlation matrix
expectedReturns = [0.0527; 0.0235; 0.0650; 0.0658; 0.0633; 0.0400; 0.0529; 0.0634];
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
covarianceMatrix = diag(stdDevs) * correlationMatrix * diag(stdDevs);

% Define risk aversion coefficients
riskAversions = [1.25, 3.5, 4.5];

% Define fund names for the legend
fundNames = {'BP Amoco', 'Income Fund', 'Fidelity Blue Chip Growth', ...
    'Vanguard Growth & Income', 'Vanguard Windsor', 'Vanguard Wellesley Income', ...
    'JP Morgan Trust International', 'Vanguard Small Cap Index'};

% Exhibit 2 portfolio weights
weights_exhibit2 = [0.16; 0.508; 0.045; 0.106; 0.146; 0.022; 0.007; 0.005];

% Function to calculate optimal portfolio allocation using mean-variance optimization
calculateOptimalPortfolio = @(mu, Sigma, riskAversion) quadprog(riskAversion * Sigma, -mu, [], [], ones(1, length(mu)), 1, zeros(length(mu), 1), []);

% Initialize figure for efficient frontier
figure;
hold on;
colors = ['r', 'g', 'b'];

% Loop over risk aversion levels to compute efficient portfolios
for i = 1:length(riskAversions)
    riskAversion = riskAversions(i);
    
    % Compute the optimal portfolio allocation
    optimalWeights = calculateOptimalPortfolio(expectedReturns, covarianceMatrix, riskAversion);
    portfolioReturn = optimalWeights' * expectedReturns;
    portfolioSD = sqrt(optimalWeights' * covarianceMatrix * optimalWeights);
    
    % Plot the efficient portfolio point on the efficient frontier
    scatter(portfolioSD, portfolioReturn, 100, colors(i), 'filled');
    
    % Display results for the optimal portfolio
    fprintf('Risk Aversion: %.2f\n', riskAversion);
    fprintf('Optimal Weights:\n');
    disp(optimalWeights');
    fprintf('Expected Portfolio Return: %.4f\n', portfolioReturn);
    fprintf('Expected Portfolio Standard Deviation: %.4f\n\n', portfolioSD);
end

% Calculate portfolio return, standard deviation, Sharpe ratio, and utility for Exhibit 2 portfolio
ret_exhibit2 = weights_exhibit2' * expectedReturns;
var_exhibit2 = weights_exhibit2' * covarianceMatrix * weights_exhibit2;
std_exhibit2 = sqrt(var_exhibit2);

% Assume a risk aversion level of 3.5 for Exhibit 2 portfolio utility
sharpe_exhibit2 = ret_exhibit2 / std_exhibit2;
utility_exhibit2 = ret_exhibit2 - 0.5 * 3.5 * var_exhibit2;

% Plot Exhibit 2 portfolio on the same graph
scatter(std_exhibit2, ret_exhibit2, 100, 'k', 'filled');

% Add legend and labels to the graph
legend({'Risk Aversion 1.25', 'Risk Aversion 3.5', 'Risk Aversion 4.5', 'Exhibit 2 Portfolio'});
title('Efficient Frontier and Exhibit 2 Portfolio');
xlabel('Standard Deviation (Risk)');
ylabel('Expected Return');
grid on;
hold off;

% Display results for Exhibit 2 Portfolio
fprintf('Exhibit 2 Portfolio\n');
fprintf('Expected Return: %.4f\n', ret_exhibit2);
fprintf('Standard Deviation: %.4f\n', std_exhibit2);
fprintf('Sharpe Ratio: %.4f\n', sharpe_exhibit2);
fprintf('Utility: %.4f\n', utility_exhibit2);
