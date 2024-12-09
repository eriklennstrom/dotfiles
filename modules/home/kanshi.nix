{...}:
{
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = [
      {
        profile.name = "undocked"; 
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 1.1;
            status = "enable";
          }
        ];
      }
      {
        profile.name = "office";
        profile.outputs = [
          {
            criteria = "Samsung Electric Company LS24A40xU H4TT900273";
            position = "7160,86";
            mode = "1920x1080@74.97Hz";
            transform = "270";
          }
          {
            criteria = "Samsung Electric Company C34J79x H4ZN100633";
            position = "3720,315";
            mode = "3440x1440@99.98200";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
    ];
  };
}
