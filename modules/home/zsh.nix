{config, lib, pkgs, ...}:
let
  myAliases = {
    # Nice to have
    t 		= "tmux";
    cat 	= "bat";
    vim 	= "nvim";
    htop 	= "btm";
    ssh		= "kitty +kitten ssh";
    ls 		= "eza --icons -l -T -L=1";
    copy 	= "xclip -selection clipboard";
    paste 	= "xclip -o -selection clipboard";

    # PHP
    a 		= "php artisan";

    # Docker
    d 		= "docker";
    dc 		= "docker compose";

    # Git
    g		= "git";
    gs		= "git s";
    lg		= "lazygit";
    pull	= "git pull";
    push	= "git push";
    co		= "git checkout";
    nah		= "git reset --hard;git clean -df";
    main	= "git checkout $([`git rev-parse --quiet --verify master` ] && echo 'master' || echo 'main')";

    # NPM
    install	= "npm install";
    serve	= "npm run serve";
    testu	= "npm run test:unit";

  };
in
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = { 
      enable = true;
      theme = "robbyrussell";
    };
    enableCompletion = true;
    shellAliases = myAliases;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
  home.packages = with pkgs; [
    gnugrep gnused
    nix-direnv
    bat eza bottom fd bc
    killall
    playerctl
    disfetch lolcat cowsay onefetch
  ];
}
