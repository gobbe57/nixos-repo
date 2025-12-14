# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs,  ... }:


let
  /*ncspot-fixad = let
    originalPkg = pkgs.ncspot;
  in pkgs.rustPlatform.buildRustPackage {
    inherit (originalPkg) pname meta buildInputs nativeBuildInputs;

    version = "1.3.1-fix-librespot-spotifyuri-api";
    src = pkgs.fetchFromGitHub {
      owner = "gui-wf";
      repo = "ncspot";
      rev = "b77c2d0037d7b7c140ebccc60bea1119ec487acc";
      hash = "sha256-BQkCJm5TSOmz9bn00AU/cjLTyq89ygf5wqMay+EWWTs=";
    };
    cargoHash = "";


  };
  */
  #unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-minecraft.nixosModules.minecraft-servers
    ];
  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/var/lib/koola-servrar";

    servers = {
      kool-server = {
        enable = true;
        package = pkgs.fabricServers.fabric;

        serverProperties = {
          motd = "mysiga tordis källare";
          gamemode = "survival";
          difficulty = "hard";
          simulation-distance = 10;
          level-seed = "4";

        };

        whitelist = {

        };

        symlinks = {
          "mods" = ./mods;
        };
      };
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.mounts = [
    {
      what = "/dev/nvme0n1";
      where = "/mnt/gibb";
      options = "mode=1770, gid=100";
    }
  ];

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.iwd.enable = true;  # Enables wireless support via wpa_supplicant.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  # Extra hosts NOTE snabb fix för ncspot tills nästa droppe

  #networking.extraHosts =
  #  ''
  #    ::0 apresolve.spotify.com
  #  '';

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "sv_SE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ALL = "sv_SE.UTF-8";
    LC_CTYPE = "sv_SE.UTF-8";
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MESSAGES = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
    LC_COLLATE = "sv_SE.UTF-8";
  };

  # kanske visar 500gb hårddisken
  services.udisks2.enable = true;

  # enables opengl
  hardware.graphics = {
    enable = true;
    # driSupport32Bit = true;
  };

  # enables nvidia drivers
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = true;

  # hardware.bluetooth = {
  #   enable = true;
  #   powerOnBoot = true;
  #   settings = {
  #     General = {
  #       Experimental = true; # Show battery charge of Bluetooth devices
  #     };

  #steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  programs.gamemode.enable = true;


  #NOTE ta bort detta sen
  # nixpkgs.config.allowBroken = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      gobbe = import ./home.nix;
    };
  };
  # awtostart
  #systemd.user.services.ncspot.enable = true;

  #systemd.user.services.spotifyd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gobbe = {
    isNormalUser = true;
    description = "gobbe";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [

      # unstable.ncspot

      #ncspot-fixad
      #pkgs.spotify-qt
      #pkgs.librespot
      #pkgs.spotifyd

      pkgs.krita
      ironwail
      python313Packages.opencv-python
      pkgs.python3
      pkgs.prismlauncher
      pkgs.hmcl
      legcord
      discord

      # pkgs.itch
      pkgs.r2modman

      pkgs.librewolf
      vim

      pkgs.kdePackages.kmail-account-wizard
      pkgs.kdePackages.kmail

      kdePackages.kate
      pkgs.ffmpeg_6
      pkgs.yt-dlp

      pkgs.gimp
      pkgs.vlc

      pkgs.reaper
      pkgs.audacity

      kdePackages.kate
      pkgs.blender

      pkgs.git
      pkgs.gcc

      pkgs.sfxr
      pkgs.godot

      pkgs.beats
      kdePackages.filelight

      pkgs.protonup-qt

      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })

      thunderbird

    ];
  };



  # Enable automatic login for the user.
  # services.xserver.displaymanager.lightdm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "gobbe";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  /*environment.variables =
  let
    makePluginPath = format:
      (lib.makeSearchPath format [
        "$HOME/.nix-profile/lib"
        "/run/current-system/sw/lib"
        "/etc/profiles/per-user/$USER/lib"
      ])
      + ":$HOME/.${format}";
  in
  {
    DSSI_PATH = makePluginPath "dssi";
    LADSPA_PATH = makePluginPath "ladspa";
    LV2_PATH = makePluginPath "lv2";
    LXVST_PATH = makePluginPath "lxvst";
    VST_PATH = makePluginPath "vst";
    VST3_PATH = makePluginPath "vst3";
  };*/

  services.flatpak.enable = true;


  environment.systemPackages = with pkgs; [

    #ncspot-fixad

    inputs.unstable.legacyPackages.x86_64-linux.ncspot
    inputs.unstable.legacyPackages.x86_64-linux.kdePackages.kdenlive

    # pkgs.vinegar
    pkgs.jdk8_headless

    # ingen kokplatta
    pkgs.mprocs
    pkgs.wiki-tui
    pkgs.bacon
    pkgs.yazi
    pkgs.gitui
    pkgs.fish

    pkgs.zoom-us
    pkgs.chickenPackages_5.chickenEggs.mpd-client
    pkgs.nuclear
    pkgs.betterdiscordctl
    pkgs.github-desktop
    # riktig neger pkgs.minecraft
    winetricks
    wineWowPackages.stable
    wineWowPackages.waylandFull

    kdePackages.kio-admin
    pkgs.fontforge-gtk

    pkgs.libreoffice-qt6-fresh
    pkgs.pkg-config
    pkgs.alsa-lib

    kdePackages.partitionmanager
    kdePackages.akregator
    lutris
    bottles
    protonup-ng
    mangohud

    protonvpn-gui #vpn skiten

  ];


  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatabilitytols.d";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enab
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall.checkReversePath = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}

