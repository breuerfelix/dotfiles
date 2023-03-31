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

    loader = {
      systemd-boot = {
        enable = true;
        # /boot/efi is a small partition
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  # TODO switch to labels
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/48199c45-de75-4a8a-be1b-32b03c29a13b";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/76EE-E5BC";
      fsType = "vfat";
    };
    # shared with windows
    "/data" = {
      device = "/dev/disk/by-label/DATA";
      fsType = "exfat";
      options = [
        "defaults"
        "uid=1000"
        "gid=100"
      ];
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
  #};

  #swapDevices = [{ device = "/dev/disk/by-label/swap"; }];
  # TODO add swap
  swapDevices = [ ];

  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

    # TODO enable custom fan control
    #fancontrol = {
    #enable = true;
    #config = "";
    #};
  };

  # TODO
  #powerManagement.cpuFreqGovernor = lib.mkDefault "conservative";
}
