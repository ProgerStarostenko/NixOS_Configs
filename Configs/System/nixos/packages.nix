{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.systemPackages = with pkgs; [
    firefox
    telegram-desktop
    kitty
    wofi
    ranger
    obsidian
    swww

    git
    python
    (python3.withPackages (ps: with ps; [ requests ]))
    
    xwayland
    hyprland
    pipewire

    home-manager
  ];
}