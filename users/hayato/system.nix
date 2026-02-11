{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hayato = {
    isNormalUser = true;
    description = "hayato";
    extraGroups = [
      "networkmanager"
      "wheel"
      "tss" # TPM2
      "docker"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };
}
