{ ... }: 
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    # plugins = {
    #   vam.knownPlugins = pkgs.vimPlugins;
    #   vam.pluginsDictionaries = let
    #     names = [
    #     "fzf-vim"
    #     "fxfWrapper"
    #     ];
    #   in map (name: {inherit name;}) names;
    # };
  };
}
