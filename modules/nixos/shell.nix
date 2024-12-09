{ pkgs, ... }:
{
  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      fzf
    ];
  };
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
