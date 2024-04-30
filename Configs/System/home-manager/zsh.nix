{ config, ...}: {
  programs.zsh = {
    enable = true;
    enbaleCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 1000;
    history.path = "${config.xdg.dataHome}/.zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "kordan";
    };
  };
}