{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
  };

  networking = {
    hostName = "LetOS";
    networkmanager.enable = true;
    nftables.enable = true;

    firewall = {
      enable = true;
      # allowedTCPPorts = [ ];
    };
  };

  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
    extraLocales = [ "en_US.UTF-8/UTF-8" "pt_BR.UTF-8/UTF-8" ];
  };

  console.keyMap = "br-abnt2";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  services.openssh.enable = true;

  users.users.scalet = {
    isNormalUser = true;
    description = "Rafael Scalet de Lima";
    extraGroups = [ "wheel" "video" "audio" "inputs" "disk" "networkmanager" ];
    hashedPassword =
      "$y$j9T$JsOBDwIjHYVI6ca7HGznT1$6tuhxbT1Ip6c31s/T2URx894FeyH4xEj199N4K85M38";
  };

  xdg = {
    terminal-exec.enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config = { common = { default = [ "gtk" ]; }; };
    };
  };

  programs.firefox.enable = true;

  programs.niri.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    nirius
    xwayland-satellite
    kitty
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --greeting 'Welcome to ${config.networking.hostName}' \
            --asterisks \
            --remember \
            --remember-user-session \
            --time \
            --cmd niri
        '';
        user = "greeter";
      };
    };
  };

  system.stateVersion = "25.11";
}

