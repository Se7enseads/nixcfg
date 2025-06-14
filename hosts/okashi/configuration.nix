# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  imports = [ ./hardware-configuration.nix ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable networking
  networking.hostName = "okashi"; # Define your hostname.

  programs = {
    # TODO: Make this dynamic based on user wm
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Africa/Nairobi";

  # Do not change this line unless you know what you are doing.
  system.stateVersion = "24.11"; # Did you read the comment?
}
