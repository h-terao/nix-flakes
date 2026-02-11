{ delib, ... }:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "hayato");
    userfullname = readOnly (strOption "h-terao");
    useremail = readOnly (strOption "h-terao@ymail.ne.jp");
  };
}
