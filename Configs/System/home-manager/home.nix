{
  imports = [
    ./modules/bundle.nix
    ./zsh.nix
  ];

  home = {
    username = "gleb";
    homeDirectory = "/home/gleb";
    stateVersion = "23.11";
  }
}