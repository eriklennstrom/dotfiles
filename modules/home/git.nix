{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Erik Tedfelt Lennström";
    userEmail = "erik@tedfeltlennstrom.se";
    extraConfig = {
      url = {
        "ssh://git@github.com/varnish" = {
          insteadOf = [
            "https://github.com/varnish"
          ];
        };
        "git@github.com:" = {
          insteadOf = [
            "https://github.com/"
          ];
        };
      };
    };
  };
}
