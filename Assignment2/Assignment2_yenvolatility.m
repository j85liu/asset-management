% Data for Risk Aversion = 3.5
yen_volatility_3_5 = [0.06, 0.10, 0.11, 0.12, 0.16];
riskless_3_5 = [0.581472355, 0.341979172, 0.309321011, 0.282105877, 0.207264257];
us_equity_3_5 = [0.73496696, 0.73496696, 0.73496696, 0.73496696, 0.73496696];
japan_equity_3_5 = [0.282293641, 0.282293641, 0.282293641, 0.282293641, 0.282293641];
japan_money_market_3_5 = [-0.598732955, -0.359239773, -0.326581612, -0.299366478, -0.224524858];
expected_return_3_5 = [0.122528346, 0.122528346, 0.122528346, 0.122528346, 0.122528346];
standard_deviation_3_5 = [0.143952717, 0.143952717, 0.143952717, 0.143952717, 0.143952717];

% Data for Risk Aversion = 2.0
yen_volatility_2_0 = [0.06, 0.10, 0.11, 0.12, 0.16];
riskless_2_0 = [0.26757662, -0.151536448, -0.20868823, -0.256314715, -0.387287549];
us_equity_2_0 = [1.28619218, 1.28619218, 1.28619218, 1.28619218, 1.28619218];
japan_equity_2_0 = [0.494013871, 0.494013871, 0.494013871, 0.494013871, 0.494013871];
japan_money_market_2_0 = [-1.047782672, -0.628669603, -0.571517821, -0.523891336, -0.392918502];
expected_return_2_0 = [0.176924606, 0.176924606, 0.176924606, 0.176924606, 0.176924606];
standard_deviation_2_0 = [0.251917255, 0.251917255, 0.251917255, 0.251917255, 0.251917255];

% Create figure for Risk Aversion = 3.5
figure;
subplot(2,1,1); % Subplot 1: Risk Aversion 3.5
hold on;
plot(yen_volatility_3_5, riskless_3_5, '-o', 'DisplayName', 'Riskless');
plot(yen_volatility_3_5, us_equity_3_5, '-o', 'DisplayName', 'US Equity');
plot(yen_volatility_3_5, japan_equity_3_5, '-o', 'DisplayName', 'Japan Equity');
plot(yen_volatility_3_5, japan_money_market_3_5, '-o', 'DisplayName', 'Japan Money Market');
xlabel('Yen Volatility');
ylabel('Portfolio Weights');
title('Risk Aversion = 3.5');
legend;
hold off;

% Create figure for Risk Aversion = 2.0
subplot(2,1,2); % Subplot 2: Risk Aversion 2.0
hold on;
plot(yen_volatility_2_0, riskless_2_0, '-o', 'DisplayName', 'Riskless');
plot(yen_volatility_2_0, us_equity_2_0, '-o', 'DisplayName', 'US Equity');
plot(yen_volatility_2_0, japan_equity_2_0, '-o', 'DisplayName', 'Japan Equity');
plot(yen_volatility_2_0, japan_money_market_2_0, '-o', 'DisplayName', 'Japan Money Market');
xlabel('Yen Volatility');
ylabel('Portfolio Weights');
title('Risk Aversion = 2.0');
legend;
hold off;

% Optional: Save the figure
% saveas(gcf, 'portfolio_weights_vs_yen_volatility.png');
