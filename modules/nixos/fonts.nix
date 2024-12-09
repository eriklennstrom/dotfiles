{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.fira-code
    nerd-fonts.d2coding
    nerd-fonts.ubuntu
    nerd-fonts.caskaydia-cove
    nerd-fonts.fantasque-sans-mono
  ];
}
