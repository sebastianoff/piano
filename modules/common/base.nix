{ pkgs, ... }:
{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  environment.variables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  nixpkgs.config.allowUnfree = true;

  programs.command-not-found.enable = false;
  programs.nix-index.enable = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    git
    helix
    wget
    curl
    htop
    pciutils
    usbutils
    man-pages
    man-pages-posix
  ];

  documentation = {
    enable = true;
    nixos.enable = true;
    man.enable = true;
  };

  system.stateVersion = "24.05";
}
