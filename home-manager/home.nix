{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dk";
  home.homeDirectory = "/home/dk";
  
  ## Settings for other Distros ##
 
  targets.genericLinux.enable = true;
  xdg.enable=true;
  xdg.mime.enable=true;
   
  ## set up bash ##

  programs.bash = {
    enable = true;
    bashrcExtra = ''
    # .bashrc

     # If not running interactively, don't do anything
     [[ $- != *i* ]] && return

     alias ls='ls --color=auto'
     PS1='[\u@\h \W]\$ '
    '';    
  };

  ## zoxide ##
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  ## hyprland ##

  programs.waybar.enable = true;
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  
  ## packages ##


  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [

 ## Graphics > nixgl ##

    pkgs.nixgl.nixGLIntel
    

 ## General ##
    pkgs.firefox-esr
    pkgs.mosh
    pkgs.btop
    pkgs.fastfetch
    pkgs.libreoffice-fresh
    pkgs.unrar
    pkgs.unzip
    pkgs.zip
    pkgs.android-file-transfer
    pkgs.remmina
    pkgs.moonlight-qt
    pkgs.clapper
    pkgs.trayscale
    pkgs.android-tools
    pkgs.rpi-imager
#    pkgs.blueman
    pkgs.iwgtk
    pkgs.mkvtoolnix
    pkgs.gnumake
    pkgs.git
    pkgs.eza
    pkgs.ugm
    pkgs.darkman
    
 ## Hyprland ##
#    pkgs.grim
#    pkgs.slurp
    pkgs.hyprshot
    pkgs.brightnessctl
    pkgs.rofi-wayland
    pkgs.wl-clipboard
    pkgs.gnome-text-editor
    pkgs.gnome-calculator
    pkgs.dunst

  ## Yazi ##
#    pkgs.yazi  # installed via xbps
    pkgs.jq
    pkgs.poppler
    pkgs.fd
    pkgs.ripgrep
    pkgs.fzf
    pkgs.resvg
    pkgs.imagemagick
    pkgs.ffmpeg

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dk/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true; 
}
