{ config, pkgs, ... }:

{
  home.username = "nik";
  home.homeDirectory = "/home/nik";

  home.stateVersion = "25.05"; 
  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  home.shellAliases = {
    edit = "sudo vim /etc/nixos/configuration.nix";
    editflake = "sudo vim /etc/nixos/flake.nix";
    edithome = "sudo vim /etc/nixos/home.nix";
    commit = "sudo ./gitcommit.sh";
  };


  programs.home-manager.enable = true;
}
