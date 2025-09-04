# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./accel.nix
      ./nvidia.nix
      ./plymouth.nix
      ./secure-boot.nix
    #  ./gnome.nix
      ./hyprland.nix
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  boot.kernel.sysctl = { 
   "vm.swappiness" = 150; 
   "vm.vfs_cache_pressure" = 50; 
   "vm.dirty_bytes" = 268435456; 
   "vm.page-cluster" = 0; 
   "vm.dirty_background_bytes" = 67108864; 
   "vm.dirty_writeback_centisecs" = 1500;
   "kernel.nmi_watchdog" = 0;
   "kernel.unprivileged_userns_clone" = 1;
   "kernel.printk" = "3 3 3 3";
   "kernel.kptr_restrict" = 2;
   "kernel.kexec_load_disabled" = 1;
   "net.core.netdev_max_backlog" = 4096;
   "fs.file-max" = 2097152;
  };
 
#  boot.initrd.luks.devices."swao".device = "/dev/disk/by-uuid/84def1a6-f7d3-475b-8483-b53cdab179c7";
  boot.initrd.systemd.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dk = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  
  # Set Z Shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh = {
  enable = true;
  enableCompletion = true;
  enableBashCompletion = true;
  autosuggestions.enable = true;
  autosuggestions.strategy = [ "history" "completion" ];
  syntaxHighlighting.enable = true;
   ohMyZsh = { # "ohMyZsh" without Home Manager
   enable = true;
   plugins = [ "git" "zoxide" ];
   theme = "agnoster";
  };
}; 

 
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ox
  trayscale
  superfile
  yazi
  mosh
  git
  gnumake
  unzip
  unrar
  zstd
  lz4
  eza
  zoxide
  btop
  nvitop
  nautilus
  loupe
  gnome-text-editor
  gnome-calculator
  file-roller
  fastfetch
  isd
  niv
  gtk-engine-murrine
  gnome-themes-extra
  ];
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.thermald.enable = true;
  services.tlp = {
      enable = true;
      settings = {
       PLATFORM_PROFILE_ON_AC= "quiet";
       PLATFORM_PROFILE_ON_BAT= "balanced";
       DEVICES_TO_DISABLE_ON_STARTUP="bluetooth";
      };
  };

  zramSwap.enable = true;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  services.switcherooControl.enable = true;
  services.fwupd.enable = true;  

  nix.gc = {
  automatic = true;
  dates = "daily";
  options = "--delete-older-than 7d";
  };
  nix.optimise.automatic = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "25.05"; # Did you read the comment?
}
