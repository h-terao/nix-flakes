{
  delib,
  myconfig,
  ...
}:
delib.module {
  name = "programs.git";
  options = delib.singleEnableOption true;

  home.ifEnabled =
    {
      myconfig,
      ...
    }:
    {
      programs.git = {
        enable = true;
        settings = {
          user.name = myconfig.constants.userfullname;
          user.email = myconfig.constants.useremail;
          init.defaultBranch = "main";
        };
      };
    };
}
