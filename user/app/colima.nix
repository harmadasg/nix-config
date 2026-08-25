{pkgs, ...}: {

  services.colima = {
    enable = true;

    profiles.default = {
      isActive = true;
      isService = true;

      # Written to ~/.colima/default/colima.yaml by home-manager.
      # Only deltas from Colima 0.10.3 defaults that are worth pinning.
      settings = {
        cpu = 8;
        memory = 12;
        disk = 100;
        arch = "aarch64";

        vmType = "vz";           # Apple Virtualization.Framework
        rosetta = true;          # amd64 emulation via Rosetta

        mountType = "virtiofs";  # fastest mount under vz
        mountInotify = true;     # propagate host FS events (nodemon, Vite, webpack)

        autoActivate = true;

        network = {
          dns = [ "1.1.1.1" "8.8.8.8" ];
        };
      };
    };
  };

  home.packages = with pkgs; [
    docker-client   # docker CLI, no daemon (Colima provides the daemon)
    docker-compose
    docker-buildx
  ];
}
