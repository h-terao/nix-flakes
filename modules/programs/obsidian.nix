{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.obsidian";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.obsidian = {
      enable = true;
      package = pkgs.obsidian;
      # See https://mynixos.com/home-manager/options/programs.obsidian
      # vaults = {
      #   # I like fancy names for my vaults😉
      #   Grimore = {
      #     enable = true;
      #     target = "Documents/Obsidian/Grimoire";
      #     settings = {
      #       corePlugins = [
      #         "backlink"
      #         "bases"
      #         "bookmarks"
      #         "canvas"
      #         "command-palette"
      #         "daily-notes"
      #         "editor-status"
      #         "file-explorer"
      #         "file-recovery"
      #         "global-search"
      #         "graph"
      #         "note-composer"
      #         "outgoing-link"
      #         "outline"
      #         "page-preview"
      #         "switcher"
      #         "tag-pane"
      #         "templates"
      #         "word-count"
      #       ];
      #     };
      #   };
      # };
    };
  };
}
