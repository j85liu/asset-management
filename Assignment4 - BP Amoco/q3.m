% Parameters
expected_returns = [0.0495, 0.0479, 0.0477]; % Expected returns for 50% BP, 5% BP, and Optimal
std_devs = [0.1816, 0.0902, 0.0885]; % Standard deviations for 50% BP, 5% BP, and Optimal
portfolio_names = {'50% BP', '5% BP', 'Optimal'};

% Define the range for the normal distribution
x = -0.5:0.001:0.5; % Range of returns from -0.5 to 0.5
hold on;

% Plot normal distributions for each portfolio
for i = 1:length(expected_returns)
    % Calculate normal distribution values
    y = normpdf(x, expected_returns(i), std_devs(i));
    plot(x, y, 'DisplayName', portfolio_names{i}, 'LineWidth', 1.5);
end

% Add labels and legend
xlabel('Expected Return');
ylabel('Probability Density');
title('Normal Distribution of Expected Returns for Portfolios');
legend('show');
grid on;

hold off;

% Parameters
expected_returns = [0.0495, 0.0479, 0.0477]; % Expected returns for 50% BP, 5% BP, and Optimal
std_devs = [0.1816, 0.0902, 0.0885]; % Standard deviations for 50% BP, 5% BP, and Optimal
thresholds = [-0.05, -0.1, -0.2, -0.3]; % Threshold returns of -5%, -10%, -20%, -30%
portfolio_names = {'50% BP', '5% BP', 'Optimal'};

% Initialize matrix to hold probabilities for each threshold
probabilities = zeros(length(thresholds), length(expected_returns));

% Calculate probabilities for each portfolio and threshold
for i = 1:length(expected_returns)
    for j = 1:length(thresholds)
        probabilities(j, i) = normcdf(thresholds(j), expected_returns(i), std_devs(i));
    end
end

% Display probabilities
for j = 1:length(thresholds)
    for i = 1:length(portfolio_names)
        fprintf('%s: Probability of return < %.2f = %.4f%%\n', portfolio_names{i}, thresholds(j), probabilities(j, i) * 100);
    end
    fprintf('\n'); % Add a blank line between threshold outputs
end
