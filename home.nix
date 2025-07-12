{ config, pkgs, ... }:

{
  home.username = "nik";
  home.homeDirectory = "/home/nik";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
  home-manager
  ];

  home.file = {
  };

    home.shellAliases = {
    edit = "sudo vim /etc/nixos/configuration.nix";
    editflake = "sudo vim /etc/nixos/flake.nix";
    edithome = "sudo vim /etc/nixos/home.nix";
    commit = "./gitcommit.sh";
    rebuild = "sudo nixos-rebuild switch --show-trace --flake /etc/nixos#leanas";
    cdx = "cd /etc/nixos";
  };

  home.sessionVariables = {
  };

    programs.bash.enable = true;
    programs.home-manager.enable = true;
}
