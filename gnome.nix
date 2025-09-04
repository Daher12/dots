{ config, pkgs, ... }:

{
  services.xserver = {
   enable = false;
   displayManager.gdm = {
    enable = true;
    wayland = true;
   };

  desktopManager.gnome = {
   enable = true;
   extraGSettingsOverridePackages = [ pkgs.mutter ];
   extraGSettingsOverrides = ''
    [org.gnome.mutter]
     experimental-features=['scale-monitor-framebuffer']
       '';
   };
 };

  services.gnome.core-apps.enable = false;
  services.power-profiles-daemon.enable = false;


  environment.systemPackages = with pkgs; [
    ghostty
    gnome-tweaks
    gnome-browser-connector
  ];
}
