{ pkgs, lib, ...}:
{
  imports = 
    [
      ./hardware-configuration.nix
      #<nixos-hardware/common/cpu/intel>
      #<nixos-hardware/common/pc/laptop>
      ##<nixos-hardware/common/pc/laptop/ssd>
    ];
  hardware.graphics = {
    enable = true;
  };
  swapDevices = [{
    device = "/swapfile";
    size = 32 * 1024; # 32GB
  }];
  hardware.intelgpu.driver = "xe";
  hardware.intelgpu.vaapiDriver = "intel-media-driver";
  #boot.kernelParams =["i915.enable_psr=0"];
  boot.kernelParams = ["i915.force_probe=!7d55" "xe.force_probe=7d55" "thinkpad_acpi.fan_control=1" "msr.allow_writes=on" "cpuidle.governor=teo"];
  services.thermald.enable = true;
}
