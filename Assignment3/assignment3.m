% MATLAB code to plot Utility(STCMM) and Utility of Leveraged US Portfolio

% Parameters
E_R_STCMM = 14.69 / 100;   % Expected return of STCMM
sigma_STCMM = 32.5 / 100;  % Volatility of STCMM
E_R_US = 12.46 / 100;      % Expected return of US portfolio
R_f = 5 / 100;             % Risk-free rate
sigma_US = 15.76 / 100;    % Volatility of US portfolio

% Range for risk aversion (A) and leverage
A = linspace(1, 20, 100);   % Risk aversion parameter (A) values
leverage = linspace(0, 2, 100);  % Leverage from 0 to 2

% Utility of STCMM as a function of A
Utility_STCMM = E_R_STCMM - 0.5 * A .* sigma_STCMM^2;

% Expected return and volatility of leveraged US portfolio as a function of leverage
E_R_leveraged = leverage * E_R_US + (1 - leverage) * R_f;
sigma_leveraged = leverage * sigma_US;

% Utility of leveraged US portfolio as a function of leverage and risk aversion A
% Choose a specific value of A for illustrative purposes
A_val = [2, 5, 10];  % Different levels of risk aversion for the leveraged portfolio

% Plotting
figure;

% Plot 1: Utility(STCMM) as a function of A
subplot(2, 2, 1);
plot(A, Utility_STCMM, 'r', 'LineWidth', 2);
title('Utility of STCMM Fund vs A');
xlabel('Risk Aversion (A)');
ylabel('Utility(STCMM)');
grid on;

% Plot 2: Expected return of leveraged US portfolio as a function of leverage
subplot(2, 2, 2);
plot(leverage, E_R_leveraged, 'b', 'LineWidth', 2);
title('Expected Return of Leveraged US Portfolio');
xlabel('Leverage');
ylabel('Expected Return');
grid on;

% Plot 3: Volatility of leveraged US portfolio as a function of leverage
subplot(2, 2, 3);
plot(leverage, sigma_leveraged, 'g', 'LineWidth', 2);
title('Volatility of Leveraged US Portfolio');
xlabel('Leverage');
ylabel('Volatility');
grid on;

% Plot 4: Utility of leveraged US portfolio for different risk aversion levels
subplot(2, 2, 4);
hold on;
for i = 1:length(A_val)
    Utility_leveraged = E_R_leveraged - 0.5 * A_val(i) * sigma_leveraged.^2;
    plot(leverage, Utility_leveraged, 'LineWidth', 2, 'DisplayName', ['A = ' num2str(A_val(i))]);
end
hold off;
title('Utility of Leveraged US Portfolio vs Leverage');
xlabel('Leverage');
ylabel('Utility (Leveraged US)');
legend show;
grid on;

% Adjust layout for better visibility
sgtitle('Utility Comparison: STCMM vs Leveraged US Portfolio');

% Parameters
E_R_STCMM = 14.69 / 100;   % Expected return of STCMM
sigma_STCMM = 32.5 / 100;  % Volatility of STCMM
E_R_US = 12.46 / 100;      % Expected return of US portfolio
R_f = 5 / 100;             % Risk-free rate
sigma_US = 15.76 / 100;    % Volatility of US portfolio

% Range for risk aversion (A) and leverage
A = linspace(1, 20, 100);   % Risk aversion parameter (A) values
leverage_values = [1, 1.2, 1.5];  % Leverage levels

% Utility of STCMM as a function of A
Utility_STCMM = E_R_STCMM - 0.5 * A .* sigma_STCMM^2;

% Utility of leveraged US portfolio for different leverage levels
Utility_leveraged = zeros(length(A), length(leverage_values));
for j = 1:length(leverage_values)
    leverage = leverage_values(j);
    
    % Expected return and volatility of leveraged US portfolio
    E_R_leveraged = leverage * E_R_US + (1 - leverage) * R_f;
    sigma_leveraged = leverage * sigma_US;
    
    % Utility of leveraged portfolio as a function of A
    Utility_leveraged(:, j) = E_R_leveraged - 0.5 * A .* sigma_leveraged.^2;
end

% Plotting
figure;
hold on;

% Plot Utility of STCMM
plot(A, Utility_STCMM, 'r', 'LineWidth', 2, 'DisplayName', 'Utility(STCMM)');

% Plot Utility of leveraged US portfolio for different leverage levels
colors = ['b', 'g', 'm'];
for j = 1:length(leverage_values)
    plot(A, Utility_leveraged(:, j), colors(j), 'LineWidth', 2, 'DisplayName', ['Utility(Leveraged US), Leverage = ' num2str(leverage_values(j))]);
end

% Title and labels
title('Utility of STCMM and Leveraged US Portfolio vs Risk Aversion (A)');
xlabel('Risk Aversion (A)');
ylabel('Utility');
legend('show');
grid on;
hold off;

% Parameters
E_R_STCMM = 14.69 / 100;   % Expected return of STCMM
sigma_STCMM = 32.5 / 100;  % Volatility of STCMM
E_R_US = 12.46 / 100;      % Expected return of US portfolio
R_f = 5 / 100;             % Risk-free rate
sigma_US = 15.76 / 100;    % Volatility of US portfolio

% Risk aversion values (A)
A_values = [2, 5, 10];     % Different risk aversion values

% Range for leverage
leverage = linspace(0.5, 2, 100);  % Leverage from 0.5 to 2

% Utility of STCMM (constant for comparison, independent of leverage)
Utility_STCMM = E_R_STCMM - 0.5 * A_values .* sigma_STCMM^2;

% Utility of leveraged US portfolio as a function of leverage
Utility_leveraged = zeros(length(leverage), length(A_values));
for i = 1:length(A_values)
    A = A_values(i);
    % Expected return and volatility of leveraged US portfolio for each leverage value
    E_R_leveraged = leverage * E_R_US + (1 - leverage) * R_f;
    sigma_leveraged = leverage * sigma_US;
    
    % Utility of leveraged portfolio as a function of leverage and A
    Utility_leveraged(:, i) = E_R_leveraged - 0.5 * A * sigma_leveraged.^2;
end

% Plotting
figure;
hold on;

% Plot Utility of STCMM for each risk aversion value (as a horizontal line)
colors = ['r', 'g', 'b'];
for i = 1:length(A_values)
    plot(leverage, Utility_STCMM(i) * ones(size(leverage)), colors(i), 'LineWidth', 2, 'DisplayName', ['Utility(STCMM), A = ' num2str(A_values(i))]);
end

% Plot Utility of leveraged US portfolio for each risk aversion value
for i = 1:length(A_values)
    plot(leverage, Utility_leveraged(:, i), '--', 'LineWidth', 2, 'Color', colors(i), 'DisplayName', ['Utility(Leveraged), A = ' num2str(A_values(i))]);
end

% Title and labels
title('Utility of STCMM and Leveraged US Portfolio vs Leverage');
xlabel('Leverage');
ylabel('Utility');
legend('show');
grid on;
hold off;

% Parameters
E_R_STCMM = 14.69 / 100;   % Expected return of STCMM
sigma_STCMM = 32.5 / 100;  % Volatility of STCMM
E_R_US = 12.46 / 100;      % Expected return of US portfolio
R_f = 5 / 100;             % Risk-free rate
sigma_US = 15.76 / 100;    % Volatility of US portfolio

% Risk aversion values (A)
A_values = [2, 5, 10];     % Different risk aversion values

% Range for leverage
leverage = linspace(0, 5, 100);  % Leverage from 0 to 5

% Utility of STCMM (constant for comparison, independent of leverage)
Utility_STCMM = E_R_STCMM - 0.5 * A_values .* sigma_STCMM^2;

% Utility of leveraged US portfolio as a function of leverage
Utility_leveraged = zeros(length(leverage), length(A_values));
for i = 1:length(A_values)
    A = A_values(i);
    % Expected return and volatility of leveraged US portfolio for each leverage value
    E_R_leveraged = leverage * E_R_US + (1 - leverage) * R_f;
    sigma_leveraged = leverage * sigma_US;
    
    % Utility of leveraged portfolio as a function of leverage and A
    Utility_leveraged(:, i) = E_R_leveraged - 0.5 * A * sigma_leveraged.^2;
end

% Plotting
figure;
hold on;

% Plot Utility of STCMM for each risk aversion value (as a horizontal line)
colors = ['r', 'g', 'b'];
for i = 1:length(A_values)
    plot(leverage, Utility_STCMM(i) * ones(size(leverage)), colors(i), 'LineWidth', 2, 'DisplayName', ['Utility(STCMM), A = ' num2str(A_values(i))]);
end

% Plot Utility of leveraged US portfolio for each risk aversion value
for i = 1:length(A_values)
    plot(leverage, Utility_leveraged(:, i), '--', 'LineWidth', 2, 'Color', colors(i), 'DisplayName', ['Utility(Leveraged), A = ' num2str(A_values(i))]);
end

% Title and labels
title('Utility of STCMM and Leveraged US Portfolio vs Leverage');
xlabel('Leverage');
ylabel('Utility');
legend('show');
grid on;
hold off;

% Parameters (Expected Returns and Covariance Matrix)
E_R = [12.46; 14.69; 12] / 100;  % Expected returns of US Portfolio, STCMM, and LYMF
cov_matrix = [15.76^2, 0.7274*15.76*32.5, 0.2*15.76*35;   % Covariance matrix
              0.7274*15.76*32.5, 32.5^2, 0.15*32.5*35;
              0.2*15.76*35, 0.15*32.5*35, 35^2] / 10000;   % Convert from percentage^2
% Parameters for LYMF Fund
E_LYMF = 0.12;        % Expected return of LYMF
sigma_LYMF = 0.35;    % Standard deviation of LYMF

% Parameters for U.S. Portfolio
E_US = 0.1246;        % Expected return of U.S. portfolio
sigma_US = 0.1576;    % Standard deviation of U.S. portfolio

% Risk aversion coefficient (A) range
A = linspace(0, 10, 100);  % Risk aversion from 0 to 10

% Leverage factors for U.S. portfolio
leverage_factors = [0.5, 1, 1.5, 2];  % Different leverages

% Utility function for LYMF
U_LYMF = E_LYMF - 0.5 * A .* sigma_LYMF^2;

% Create a new figure
figure;
hold on;
grid on;

% Plot the utility of LYMF
plot(A, U_LYMF, 'r', 'LineWidth', 2, 'DisplayName', 'LYMF Fund');

% Plot the utility of U.S. portfolio for different leverage factors
for i = 1:length(leverage_factors)
    leverage = leverage_factors(i);
    U_US = leverage * E_US - 0.5 * A .* (leverage * sigma_US).^2;
    plot(A, U_US, 'DisplayName', ['US Portfolio (Leverage ' num2str(leverage) ')'], 'LineWidth', 2);
end

% Labels and legend
xlabel('Risk Aversion (A)');
ylabel('Utility');
title('Utility of LYMF Fund and U.S. Portfolio vs Risk Aversion');
legend('show');
hold off;

% Parameters for LYMF Fund
E_LYMF = 0.12;        % Expected return of LYMF
sigma_LYMF = 0.35;    % Standard deviation of LYMF

% Parameters for U.S. Portfolio
E_US = 0.1246;        % Expected return of U.S. portfolio
sigma_US = 0.1576;    % Standard deviation of U.S. portfolio

% Correlation between U.S. portfolio and LYMF fund
rho = 0.2;  % Example correlation value (you can change it as needed)

% Risk aversion coefficient (A) range
A = linspace(0, 10, 100);  % Risk aversion from 0 to 10

% Portfolio weights
w_LYMF = 0.5;  % Example weight for LYMF fund
w_US = 1 - w_LYMF;  % Remaining weight for U.S. portfolio

% Portfolio expected return
E_portfolio = w_LYMF * E_LYMF + w_US * E_US;

% Portfolio variance (accounting for correlation)
sigma_portfolio_squared = w_LYMF^2 * sigma_LYMF^2 + w_US^2 * sigma_US^2 + ...
    2 * w_LYMF * w_US * sigma_LYMF * sigma_US * rho;

% Portfolio standard deviation
sigma_portfolio = sqrt(sigma_portfolio_squared);

% Utility function for the portfolio
U_portfolio = E_portfolio - 0.5 * A .* sigma_portfolio_squared;

% Create a new figure
figure;
hold on;
grid on;

% Plot the utility of the portfolio
plot(A, U_portfolio, 'b', 'LineWidth', 2, 'DisplayName', 'Portfolio (US + LYMF)');

% Add labels and legend
xlabel('Risk Aversion (A)');
ylabel('Utility');
title('Utility of the Portfolio (US + LYMF) vs Risk Aversion');
legend('show');
hold off;

% Risk aversion levels
A_values = [2, 5, 10];

% Constants for U.S. and STCMM portfolios
expected_return_STCMM = 0.1469;
std_dev_STCMM = 0.325;

expected_return_US = 0.1246;
std_dev_US = 0.1576;
risk_free_rate = 0.05;

% Leverage range
leverage = linspace(0, 2, 100);

% Calculate utility of STCMM (independent of leverage)
utility_STCMM = @(A) expected_return_STCMM - (1/2) * A * (std_dev_STCMM)^2;

% Utility of leveraged U.S. portfolio as a function of leverage and risk aversion
utility_leveraged_US = @(A, leverage) ...
    (leverage .* expected_return_US + (1 - leverage) .* risk_free_rate) - ...
    (1/2) * A * (leverage .* std_dev_US).^2;

% Initialize figure
figure;
hold on;

% Plot difference for each risk aversion level
for A = A_values
    % Calculate utility difference
    utility_diff = utility_leveraged_US(A, leverage) - utility_STCMM(A);
    
    % Plot utility difference vs leverage
    plot(leverage, utility_diff, 'LineWidth', 2, 'DisplayName', ['A = ', num2str(A)]);
end

% Graph properties
title('Difference in Utility: Leveraged U.S. Portfolio vs STCMM');
xlabel('Leverage');
ylabel('Utility Difference (US Leveraged - STCMM)');
legend('show');
grid on;
hold off;

