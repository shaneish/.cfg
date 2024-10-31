# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  # networking.hostName = "shnixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true; #This line enables sddm

  programs.hyprland = { # we use this instead of putting it in systemPackages/users
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # This variable fixes electron apps in wayland

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # NVIDIA drivers are unfree.
  services.xserver.videoDrivers = [ "nvidia" ]; # If you are using a hybrid laptop add its iGPU manufacturer
  hardware.graphics.enable = true;

  hardware.nvidia = {
    # Enable modesetting for Wayland compositors (hyprland)
    modesetting.enable = true;
    # Use the open source version of the kernel module
    open = true;
    # Enable the Nvidia settings menu
    nvidiaSettings = true;
    # Select the appropriate driver version for your specific GPU
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shaneish = {
    isNormalUser = true;
    description = "shaneish";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      nodejs_20
      discord
      firefox
      flameshot
      mako
      bashmount
      networkmanagerapplet
      neofetch
      ranger
      feh
      cmus
      grim
      cava
      pavucontrol
      multimarkdown
      shellcheck
      vlc
      ffmpeg
    ];
    shell = pkgs.fish;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # ish
  services.flatpak.enable = true;
  programs.fish.enable = true;
  services.keyd = {

    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
    settings = {
          main = {
            capslock = "overload(control, esc)";
        esc = "capslock";
          };
          alt = {
            h = "left";
            l = "right";
            j = "down";
            k = "up";
            v = "C-v";
            c = "C-c";
          };
    };
      };
    };
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    python313
    kitty
    wget
    curl
    hyprpaper
    pywal
    lxappearance
    wofi
    waybar
    rofi-wayland
    dunst
    eww
    swaylock-effects
    zip
    ripgrep
    fd
    unzip
    fzf
    tealdeer
    sd
    git
    wezterm
    rustc
    rustup
    rustfmt
    cargo
    gcc
    stow
    llvm_18
    rm-improved
    yazi
    yazi-unwrapped
    fselect
    uutils-coreutils
    onefetch
    nushell
    eza
    rargs
    pypy310
    starship
    jetbrains-mono
    roboto-mono
    bat
    ruff
    poetry
    pyenv
    python313FreeThreading
    xclip
    wl-clipboard-rs
    google-chrome
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
