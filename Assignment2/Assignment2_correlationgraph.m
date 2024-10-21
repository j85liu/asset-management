% Define correlation values for the x-axis
correlation = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

% Data for each category
riskless = [0.0752, 0.11266994, 0.153093325, 0.200301479, 0.260763765, 0.347628785, 0.49420391, 0.820164884, 2.348062294, -2.587279396];
us_equity = [0.7768, 0.773964006, 0.768819188, 0.760461029, 0.747102042, 0.724816154, 0.68335859, 0.585558398, 0.113048389, 1.652993083];
japan_equity = [0.1865, 0.192918718, 0.20470981, 0.223865359, 0.254481995, 0.305557645, 0.400571678, 0.624713901, 1.707630419, -1.821673754];
japan_money_market = [-0.0384, -0.079552664, -0.126622323, -0.184627867, -0.262347802, -0.378002585, -0.578134179, -1.030437183, -3.168741102, 3.755960067];
expected_return = [0.11963942, 0.119833718, 0.120189217, 0.120766751, 0.121689833, 0.123229749, 0.126094395, 0.132852218, 0.165501837, 0.05909434];
standard_deviation = [0.141056645, 0.141253287, 0.141612365, 0.142193782, 0.143118166, 0.144647107, 0.147449163, 0.153857279, 0.181660466, 0.050974334];

% ---- Plot 1: Expected Return and Standard Deviation ----
figure;
hold on;
plot(correlation, expected_return, '-v', 'DisplayName', 'Expected Return');
plot(correlation, standard_deviation, '-*', 'DisplayName', 'Standard Deviation');

% Customize the plot
xlabel('Correlation');
ylabel('Value');
title('Expected Return and Standard Deviation vs Correlation');
legend('Location', 'best');
grid on;

% Set axis limits for better visibility
xlim([min(correlation)-0.01, max(correlation)+0.01]);
ylim([min([expected_return, standard_deviation])-0.05, max([expected_return, standard_deviation])+0.05]);

% ---- Plot 2: 4 Markets (Riskless, US Equity, Japan Equity, Japan Money Market) ----
figure;
hold on;
plot(correlation, riskless, '-o', 'DisplayName', 'Riskless');
plot(correlation, us_equity, '-s', 'DisplayName', 'US Equity');
plot(correlation, japan_equity, '-d', 'DisplayName', 'Japan Equity');
plot(correlation, japan_money_market, '-^', 'DisplayName', 'Japan Money Market');

% Customize the plot
xlabel('Correlation');
ylabel('Value');
title('4 Markets vs Correlation');
legend('Location', 'best');
grid on;

% Set axis limits for better visibility
xlim([min(correlation)-0.01, max(correlation)+0.01]);
ylim([min([riskless, us_equity, japan_equity, japan_money_market])-0.5, max([riskless, us_equity, japan_equity, japan_money_market])+0.5]);
