{
  delib,
  ...
}:
delib.module {
  name = "desktop.fuzzel";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.fuzzel.enable = true;
  };
}
