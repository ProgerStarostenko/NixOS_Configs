{
  imports = [
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    ./hardware-configuration.nix
    ./packages.nix
    ./modules/bundle.nix
    ./disk-config.nix
  ];

  networking.hostName = "Notebook";
  
  time.timeZone = "Europe/Minsk";

  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.05";
}