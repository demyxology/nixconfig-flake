# OS-specific config like username, groups, etc.

{ pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nikita = {
    isNormalUser = true;
    description = "nikita";

    # video added for brightness control
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
    packages = with pkgs; [ ];
  };

  nix.settings.trusted-users = [
    "root"
    "nikita"
  ];
}
