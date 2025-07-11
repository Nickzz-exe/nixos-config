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
    commit = "sudo ./gitcommit.sh";
  };

  home.sessionVariables = {
  };
  programs.bash.enable = true;
  programs.home-manager.enable = true;
}
