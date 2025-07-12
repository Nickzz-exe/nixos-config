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
    extraGroups = [ "networkmanager" "wheel" "services" ];
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
        #GIT DIRTY WARNING REMOVAL
        nix.settings.warn-dirty = false;


        #SSH	
	services.openssh.enable = true;
	services.openssh.settings = {
	PermitRootLogin = "no";
  	PasswordAuthentication = true; # Or false if using SSH keys only
	};
        
        #RAID
        systemd.services.mdmonitor.enable = false;
        boot.swraid = {
          enable = true;
          mdadmConf = ''
        ARRAY /dev/md0 metadata=1.2 UUID=4fbcc4e4:a7b1a17e:56e3f60b:4df6e4d8 
        '';};

        fileSystems."/mnt/hdd" = {
        device = "/dev/disk/by-uuid/8f5bc5e8-97c9-4c9d-9bc2-239c89887a83";
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


        #FLAKES
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        
      
        #SERVICES

          #NGINX
          services.nginx.enable = true;
          services.nginx.virtualHosts."leanas.local" = {
            #enableACME = true;
            #forceSSL = true;
            locations."/" = {
              proxyPass = "http://127.0.0.1:2283";
              proxyWebsockets = true;
              recommendedProxySettings = true;
              extraConfig = ''
                client_max_body_size 50000M;
                proxy_read_timeout   600s;
                proxy_send_timeout   600s;
                send_timeout         600s;
              '';
            };
        };


          #FIREWALLING
          networking.firewall.allowedTCPPorts = [ 2283 80 883 ];
        
          #IMMICH

          systemd.tmpfiles.rules = [
            #Type      Path         Mode User Group
            "d   /mnt/hdd/immich    0750 immich  immich -"
          ];

          services.immich = {
          environment.LOG_LEVEL = "debug";
          enable = true;
          port = 2283;
          mediaLocation = "/mnt/hdd/immich";
          host = "127.0.0.1";
          environment.IMMICH_TRUSTED_PROXIES="127.0.0.1";
          };


  #DO NOT TOUCH MORON 
  system.stateVersion = "25.05"; # Did you read the comment?

}
