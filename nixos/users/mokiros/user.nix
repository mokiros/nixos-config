{
  pkgs,
  ...
}:
{
  users.users = {
    mokiros = {
      initialPassword = "123";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.bash;
    };
  };
}
