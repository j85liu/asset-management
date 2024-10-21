% Given volatilities (in percentage form)
sigma_US = 0.1576;
sigma_Japan = 0.2268;
sigma_YenDollar = 0.11;

% Correlations for both scenarios
rho_US_Japan = 0.3032;
rho_Japan_YenDollar_5611 = 0.5611;  % Scenario 1
rho_Japan_YenDollar_485 = 0.485;    % Scenario 2

% Scenario 1: Covariance Matrix for rho_Japan_YenDollar = 0.5611
Cov_Sigma_5611 = [sigma_US^2, rho_US_Japan*sigma_US*sigma_Japan, 0, 0;
                  rho_US_Japan*sigma_US*sigma_Japan, sigma_Japan^2, rho_Japan_YenDollar_5611*sigma_Japan*sigma_YenDollar, 0;
                  0, rho_Japan_YenDollar_5611*sigma_Japan*sigma_YenDollar, sigma_YenDollar^2, 0;
                  0, 0, 0, 0];

% Scenario 2: Covariance Matrix for rho_Japan_YenDollar = 0.485
Cov_Sigma_485 = [sigma_US^2, rho_US_Japan*sigma_US*sigma_Japan, 0, 0;
                 rho_US_Japan*sigma_US*sigma_Japan, sigma_Japan^2, rho_Japan_YenDollar_485*sigma_Japan*sigma_YenDollar, 0;
                 0, rho_Japan_YenDollar_485*sigma_Japan*sigma_YenDollar, sigma_YenDollar^2, 0;
                 0, 0, 0, 0];

% Plotting heatmap for the first scenario
figure;
subplot(1, 2, 1);
heatmap(Cov_Sigma_5611, 'Colormap', parula, 'ColorbarVisible', 'on');
title('Covariance Matrix Heatmap: ρ = 0.5611');
xlabel('Assets');
ylabel('Assets');
ax1 = gca;
ax1.XDisplayLabels = {'US Equities', 'Japan Equities', 'Japan Money Market', 'US Money Market'};
ax1.YDisplayLabels = {'US Equities', 'Japan Equities', 'Japan Money Market', 'US Money Market'};

% Plotting heatmap for the second scenario
subplot(1, 2, 2);
heatmap(Cov_Sigma_485, 'Colormap', parula, 'ColorbarVisible', 'on');
title('Covariance Matrix Heatmap: ρ = 0.485');
xlabel('Assets');
ylabel('Assets');
ax2 = gca;
ax2.XDisplayLabels = {'US Equities', 'Japan Equities', 'Japan Money Market', 'US Money Market'};
ax2.YDisplayLabels = {'US Equities', 'Japan Equities', 'Japan Money Market', 'US Money Market'};
