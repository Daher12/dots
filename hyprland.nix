{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  security.polkit.enable = true;
  services.xserver.enable = false;
  services.gvfs.enable = true;
  services.greetd.enable = ture;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.dconf.profiles.user.databases = [
     {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "shell-Nord";
        icon-theme = "Fluent";
        font-name = "Sans 11";
        document-font-name = "Sans 11";
        monospace-font-name = "Noto Sans Mono Medium 11";
      };
    }
  ];
 
  environment.systemPackages = with pkgs; [
  kitty
  wl-clipboard
  dunst
  rofi-wayland
  iwgtk
  blueman
  nwg-look
  hyprlock
  xdg-utils
  xdg-user-dirs
  xdg-user-dirs-gtk
  hyprshot
  hyprpaper
  hyprpolkitagent
  greetd.tuigreet
  ];
}
