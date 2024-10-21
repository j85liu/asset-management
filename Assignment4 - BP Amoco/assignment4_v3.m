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
riskAversions = [3.5, 1.25, 4.5];

% Define fund names for the legend
fundNames = {'BP Amoco', 'Income Fund', 'Fidelity Blue Chip Growth', ...
    'Vanguard Growth & Income', 'Vanguard Windsor', 'Vanguard Wellesley Income', ...
    'JP Morgan Trust International', 'Vanguard Small Cap Index'};

% Function to calculate optimal portfolio allocation using mean-variance optimization
calculateOptimalPortfolio = @(mu, Sigma, riskAversion) quadprog(riskAversion * Sigma, -mu, [], [], ones(1, length(mu)), 1, zeros(length(mu), 1), []);

% Define percentage deviations for plotting
deviationPercentages = -0.5:0.01:0.5; % From -50% to +50% deviation from the optimal weights

% Loop over risk aversion levels
for i = 1:length(riskAversions)
    riskAversion = riskAversions(i);
    
    % Compute the optimal portfolio allocation
    optimalWeights = calculateOptimalPortfolio(expectedReturns, covarianceMatrix, riskAversion);
    portfolioReturn = optimalWeights' * expectedReturns;
    portfolioSD = sqrt(optimalWeights' * covarianceMatrix * optimalWeights);

    % (1) Display results for the optimal portfolio
    fprintf('Risk Aversion: %.2f\n', riskAversion);
    fprintf('Optimal Weights:\n');
    disp(optimalWeights');
    fprintf('Expected Portfolio Return: %.4f\n', portfolioReturn);
    fprintf('Expected Portfolio Standard Deviation: %.4f\n', portfolioSD);

    % (2) Generate graph for expected returns
    figure;
    hold on;
    for j = 1:length(optimalWeights)
        % Calculate the portfolio return for deviations in the j-th fund
        portfolioReturns = zeros(1, length(deviationPercentages));
        for k = 1:length(deviationPercentages)
            deviatedWeights = optimalWeights;
            deviatedWeights(j) = deviatedWeights(j) + deviationPercentages(k);
            deviatedWeights = deviatedWeights / sum(deviatedWeights); % Re-normalize weights to sum to 1
            portfolioReturns(k) = deviatedWeights' * expectedReturns;
        end
        plot(deviationPercentages * 100, portfolioReturns, 'DisplayName', fundNames{j});
    end
    title(sprintf('Expected Portfolio Return vs Allocation Deviation (Risk Aversion = %.2f)', riskAversion));
    xlabel('% Deviation from Optimal Allocation');
    ylabel('Expected Portfolio Return');
    legend('show');
    hold off;

    % (3) Generate graph for standard deviations
    figure;
    hold on;
    for j = 1:length(optimalWeights)
        % Calculate the portfolio standard deviation for deviations in the j-th fund
        portfolioSDs = zeros(1, length(deviationPercentages));
        for k = 1:length(deviationPercentages)
            deviatedWeights = optimalWeights;
            deviatedWeights(j) = deviatedWeights(j) + deviationPercentages(k);
            deviatedWeights = deviatedWeights / sum(deviatedWeights); % Re-normalize weights to sum to 1
            portfolioSDs(k) = sqrt(deviatedWeights' * covarianceMatrix * deviatedWeights);
        end
        plot(deviationPercentages * 100, portfolioSDs, 'DisplayName', fundNames{j});
    end
    title(sprintf('Portfolio Standard Deviation vs Allocation Deviation (Risk Aversion = %.2f)', riskAversion));
    xlabel('% Deviation from Optimal Allocation');
    ylabel('Portfolio Standard Deviation');
    legend('show');
    hold off;
end
