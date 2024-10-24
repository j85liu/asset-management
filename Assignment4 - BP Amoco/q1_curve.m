% Define inputs: Expected returns (in real terms), standard deviations, and correlation matrix
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

% Define the Exhibit 2 portfolio weights
exhibit2Weights = [0.16; 0.508; 0.045; 0.106; 0.146; 0.022; 0.007; 0.005];

% Calculate the expected return and standard deviation of the Exhibit 2 portfolio
exhibit2Return = exhibit2Weights' * expectedReturns;
exhibit2SD = sqrt(exhibit2Weights' * covarianceMatrix * exhibit2Weights);

% Function to calculate optimal portfolio allocation using mean-variance optimization
calculateOptimalPortfolio = @(mu, Sigma, riskAversion) quadprog(riskAversion * Sigma, -mu, [], [], ones(1, length(mu)), 1, zeros(length(mu), 1), []);

% Generate the efficient frontier by optimizing for different target returns
nFrontierPoints = 100; % Number of points on the efficient frontier
targetReturns = linspace(min(expectedReturns), max(expectedReturns), nFrontierPoints);
efficientSDs = zeros(1, nFrontierPoints);

for i = 1:nFrontierPoints
    % Set up the quadratic programming problem to minimize portfolio variance
    Aeq = [ones(1, length(expectedReturns)); expectedReturns'];
    beq = [1; targetReturns(i)];
    weights = quadprog(covarianceMatrix, [], [], [], Aeq, beq, zeros(length(expectedReturns), 1), []);
    efficientSDs(i) = sqrt(weights' * covarianceMatrix * weights);
end

% Plot the efficient frontier
figure;
plot(efficientSDs, targetReturns, 'b-', 'LineWidth', 2);
hold on;

% Compute and plot points for risk aversions of 1.25, 3.5, and 4.5
colors = ['r', 'g', 'm'];
for i = 1:length(riskAversions)
    riskAversion = riskAversions(i);
    weights = calculateOptimalPortfolio(expectedReturns, covarianceMatrix, riskAversion);
    portfolioReturn = weights' * expectedReturns;
    portfolioSD = sqrt(weights' * covarianceMatrix * weights);
    plot(portfolioSD, portfolioReturn, [colors(i) 'o'], 'MarkerSize', 10, 'MarkerFaceColor', colors(i));
end

% Plot the Exhibit 2 portfolio
plot(exhibit2SD, exhibit2Return, 'ks', 'MarkerSize', 10, 'MarkerFaceColor', 'k');

% Labels and legend
title('Efficient Frontier with Portfolio Points');
xlabel('Portfolio Standard Deviation');
ylabel('Portfolio Expected Return');
legend('Efficient Frontier', 'Risk Aversion = 1.25', 'Risk Aversion = 3.5', 'Risk Aversion = 4.5', 'Exhibit 2 Portfolio', 'Location', 'northwest');

hold off;
