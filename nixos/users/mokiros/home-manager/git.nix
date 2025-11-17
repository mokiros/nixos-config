{
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "mokiros";
        email = "mokiros@mokiros.dev";
      };
      init.defaultBranch = "main";
    };
    signing.format = "openpgp";
    signing.key = "20D623B706CF061C";
    signing.signByDefault = true;
  };

}
