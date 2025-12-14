{ config, pkgs, ... }:

{
  home.username = "gobbe";
  home.homeDirectory = "/home/gobbe";

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark_v2";
      vim_keys = true;
    };
  };

  /*programs.git = {
    enable = true;
    userName = "gobbe57";
    userEmail = "gobbe57@duck.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "MUSPEKARE";
    iconTheme.name = "GruvboxPlus";
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ " kwrite.desktop " ];
    "image/*"    = [ " aseprite.desktop " ];
    "video/*"    = [ " vlc.desktop " ];
  };

  programs.fish = {
    enable = true;
  };*/

  home.packages = [
    # pkgs.hello
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.file = {





  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
