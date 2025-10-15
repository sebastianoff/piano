{ ... }:
{
  networking.hostName = "piano";

  imports = [
    ./hardware-configuration.nix
  ];
}
