{ config, pkgs, ... }:

{
  services.flatpak.packages = [
    "info.portfolio_performance.PortfolioPerformance"
  ];
}
