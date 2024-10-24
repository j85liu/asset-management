% Parameters
expected_returns = [0.0495, 0.0479, 0.0477]; % Expected returns for 50% BP, 5% BP, and Optimal
std_devs = [0.1816, 0.0902, 0.0885]; % Standard deviations for 50% BP, 5% BP, and Optimal
portfolio_names = {'50% BP', '5% BP', 'Optimal'};
thresholds = [-0.05, -0.10, -0.20, -0.30]; % Return thresholds

% Initialize an array to store probabilities
probabilities = zeros(length(portfolio_names), length(thresholds));

% Calculate probabilities using the CDF of the normal distribution
for i = 1:length(portfolio_names)
    for j = 1:length(thresholds)
        probabilities(i, j) = normcdf(thresholds(j), expected_returns(i), std_devs(i)) * 100; % Convert to percentage
    end
end

% Display probabilities
for i = 1:length(portfolio_names)
    for j = 1:length(thresholds)
        fprintf('%s: Probability of return < %.2f = %.4f%%\n', portfolio_names{i}, thresholds(j), probabilities(i, j));
    end
end

% Create figure for distributions
figure;
hold on;

% Plot normal distributions
x = linspace(-0.5, 0.5, 1000); % X values for the normal distribution
for i = 1:length(expected_returns)
    y = normpdf(x, expected_returns(i), std_devs(i)); % Normal PDF
    plot(x, y, 'DisplayName', portfolio_names{i}, 'LineWidth', 2); % Plot the distribution
end

% Highlight fat tails beyond specified thresholds
for j = 1:length(thresholds)
    x_fill = linspace(thresholds(j), -0.5, 100); % Extend to the left of the threshold
    for i = 1:length(expected_returns)
        y_fill = normpdf(x_fill, expected_returns(i), std_devs(i)); % Normal PDF for each portfolio
        fill([x_fill fliplr(x_fill)], [y_fill zeros(1, 100)], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Fat Tails');
    end
end

% Add labels and legend
xlabel('Returns');
ylabel('Probability Density');
title('Normal Distributions and Fat Tails Phenomenon');
legend('show');
grid on;

% Adjust axis limits
xlim([-0.5, 0.5]);
ylim([0, max(normpdf(x, expected_returns(1), std_devs(1))) * 1.5]); % Adjust y-axis to fit all distributions
hold off;

% Display final message
fprintf('The areas shaded in red illustrate the fat tails phenomenon, indicating that the actual probability of extreme returns is higher than suggested by the normal distribution.\n');
