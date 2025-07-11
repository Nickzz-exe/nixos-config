{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "leanas"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nik = {
    isNormalUser = true;
    description = "nik";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash;
    packages = with pkgs; [
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
   vim_configurable
   wget
   git
   hd-idle
   discord-ptb
  ];

		#MY SHIT
        
        #SSH	
	services.openssh.enable = true;
	services.openssh.settings = {
	PermitRootLogin = "no";
  	PasswordAuthentication = true; # Or false if using SSH keys only
	};
        
        #RAID
        boot.swraid = {
          enable = true;
          mdadmConf = ''
            ARRAY /dev/md0 metadata=1.2 spares=1 UUID=b2531a00:38521224:8d38f374:24e6db66'';
          };

        fileSystems."/home/nik/hdd" = {
        device = "/dev/disk/by-uuid/4fbcc4e4:a7b1a17e:56e3f60b:4df6e4d8";
        fsType = "ext4";
        options = [ "nofail" ];
        };      

        
        #DISK SPINDOWN
        systemd.services.hd-idle = {
          enable = true;
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            type = "forking";
            ExecStart = "${pkgs.hd-idle}/bin/hd-idle -i 0 -a sda -i 200 -a sdb -i 200 -a sdc -i 200";
          };
        };


        #MISC
        #FLAKES
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        #IMMICH
        #service.immich.enable = true;
        #service.immich.port = 2283;
        # service.immich.mediaLocation=






  system.stateVersion = "25.05"; # Did you read the comment?

}
