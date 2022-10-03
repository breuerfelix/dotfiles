{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    #../common.nix
  ];

  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  # windows handles time in dual boot
  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "rocky";
    interfaces = {
      eno1.useDHCP = true;
      wlp6s0.useDHCP = true;
    };
  };

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      # for detecting dual boot windows
      useOSProber = true;
    };

    loader.efi.canTouchEfiVariables = true;
    cleanTmpDir = true;

    initrd = {
      kernelModules = [ "dm-snapshot" ];
      availableKernelModules = [
        "nvme" "xhci_pci" "ahci"
        "usbhid" "usb_storage" "sd_mod"
      ];

      luks.devices.root = {
        device = "/dev/disk/by-label/luks";
        preLVM = true;
        allowDiscards = true;
      };
    };

    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with pkgs.linuxPackages_latest; [ zenpower ];
    #extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

    "/data" = {
      device = "/dev/disk/by-label/DATA";
      fsType = "exfat";
      options = [
        "defaults"
        "uid=1000" "gid=100"
      ];
    };
  };

  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  hardware = {
    # high-resolution display
    video.hidpi.enable = lib.mkDefault true;
    # disable until linux 5.10 (support for amd 5600x)
    # BIOS handles fan control
    #fancontrol.enable = true;
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "conservative";
}
