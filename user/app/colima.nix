{pkgs, ...}: {

  services.colima.enable = true;

  home.packages = with pkgs; [
    docker-client   # docker CLI, no daemon (Colima provides the daemon)
    docker-compose
    docker-buildx
  ];
}