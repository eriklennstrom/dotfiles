{ inputs, ... }:
{
  environment.systemPackages = [
    inputs.rose-pine-hyprcursor.packages.x86_64-linux.default
    inputs.zen-browser.packages."x86_64-linux".default
  ];
}
