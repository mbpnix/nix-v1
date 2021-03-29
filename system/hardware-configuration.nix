{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/NIXHOME";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXEFI";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/NIXSWAP"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
