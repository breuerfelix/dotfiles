{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  # windows handles time in dual boot
  time.hardwareClockInLocalTime = true;

  networking.hostName = "rocky";

  boot = {
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    cleanTmpDir = true;
    #kernelPackages = pkgs.linuxPackages_latest;
    #extraModulePackages = with pkgs.linuxPackages_latest; [ zenpower ];

    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/48199c45-de75-4a8a-be1b-32b03c29a13b";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/76EE-E5BC";
      fsType = "vfat";
    };
  };

  #fileSystems = {
  #"/" = {
  #device = "/dev/disk/by-label/root";
  #fsType = "ext4";
  #};

  #"/boot" = {
  #device = "/dev/disk/by-label/boot";
  #fsType = "vfat";
  #};

  #"/data" = {
  #device = "/dev/disk/by-label/DATA";
  #fsType = "exfat";
  #options = [
  #"defaults"
  #"uid=1000"
  #"gid=100"
  #];
  #};
  #};

  #swapDevices = [{ device = "/dev/disk/by-label/swap"; }];
  swapDevices = [ ];

  hardware = {
    opengl.enable = true;
    # TODO maybe no mkdefault?
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
    # high-resolution display
    #video.hidpi.enable = lib.mkDefault true;
    # disable until linux 5.10 (support for amd 5600x)
    # BIOS handles fan control
    #fancontrol.enable = true;
  };

  #powerManagement.cpuFreqGovernor = lib.mkDefault "conservative";
}
