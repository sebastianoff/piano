{ pkgs, ... }:
{
  users.mutableUsers = true;

  users.users.cat = {
    isNormalUser = true;
    description = "Primary user";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
    hashedPassword = "$6$zDYb/R6dG6pKq2zd$0cTqRPZAwAOCxTYu7of0lxEsAINLxDRY3vmEoUV2.BS6EGijjUL5KUmv95k5T6WENcUl/IFWrygQRDA6FzhTJ.";
  };
}
