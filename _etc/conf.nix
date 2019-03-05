{ config, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/nvme0n1"; # or "nodev" for efi only

  networking.hostName = "sph"; # Define your hostname.
  i18n = {
     consoleFont = "sun12x22";
     consoleKeyMap = "emacs2";
     defaultLocale = "en_US.UTF-8";
  };
  #i18n.inputMethod.enabled = "fcitx";
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
     wget gnupg22 git openssh gcc gnumake42
     llvm_39 cmake pkgconfig zlib openssl ncurses
     xterm mg nvi rsync duplicity
     windowmaker wmcalclock wmsystemtray onestepback
     mplayer
     dzen2
     rxvt_unicode tmux 
     elinks
     emacs26
     docker
     powertop htop psmisc
     fira fira-mono redshift
     gimp mypaint
     arandr xdotool
     xorg.xmodmap xorg.xrandr xorg.xev xbindkeys
     lxappearance lxappearance-gtk3 fontconfig hicolor_icon_theme
     firefox leafpad kupfer chromium thunderbird
     xss-lock slock gorilla-bin
  ];

  environment.sessionVariables = {
    GTK_DATA_PREFIX = [
      "${config.system.path}"
    ];
  };
  
  environment.etc = {
    "rc.local" = { 
      text = ''
#!/bin/sh
for n in 0 1 2 3 ; do echo '3200000' > /sys/devices/system/cpu/cpufreq/policy$n/scaling_max_freq; done
echo 'auto' > '/sys/bus/usb/devices/1-4/power/control';
echo 'auto' > '/sys/bus/i2c/devices/i2c-3/device/power/control';
echo '1' > '/sys/module/snd_hda_intel/parameters/power_save';
echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs';
'';
      };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = false; };
  programs.slock.enable = true;
  programs.ssh.agentTimeout = "4h";
  programs.ssh.startAgent = true;
  programs.light.enable = true;

  systemd.services.rclocal = {
    enable = true;
    description = "Run stuff from /etc/rc.local";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /etc/rc.local";
      ExecStop = "";
      RemainAfterExit = true;
    };
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    iosevka
    ipafont
    kochi-substitute
    fira
    fira-mono
    symbola
  ];
  fonts.fontconfig.ultimate.enable = true;
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Fira Mono" "IPAGothic" ];
    sansSerif = [ "Fira Sans" "IPAPGothic" ];
    serif = [ "DejaVu Serif" "IPAPMincho" ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = true;

  services.acpid.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip  ] ;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "pl";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.libinput.tapping = false;

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.windowmaker.enable = true;


  services.xserver.displayManager.sessionCommands = ''

'';
	
  users.users.p = {
     isNormalUser = true;
     home = "/home/p";
     extraGroups = ["wheel" "audio" "video" "docker"];
     uid = 1000;
  };

  # DO NOT TOUCH	
  system.stateVersion = "18.09"; # Did you read the comment?
}
