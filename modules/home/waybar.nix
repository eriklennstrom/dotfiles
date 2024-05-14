{config, pkgs, ...}:
{
  programs.waybar.enable = true;
   
  programs.waybar.settings = {
  mainBar = {
    layer = "top";
    position = "top";
    height = 20;
    margin-left = 10;
    margin-right = 10;
    # spacing = 10;
    #output = [
      #"eDP-1"
    #];

    modules-left = [ "sway/workspaces" "sway/mode" ];
    modules-center = [ "custom/media" ];
    modules-right = [ "tray" "pulseaudio" "network" "memory" "cpu" "clock" "battery" ];
    media = {
        format = "{icon} {}";
        return-type = "json";
        max-length = 55;
        format-icons = {
          Playing = "";
          Paused = "";
        };
        exec = "mediaplayer";
        exec-if = "[ $(playerctl -l 2>/dev/null | wc -l) -ge} ]";
        interval = 1;
        on-click = "play-pause";
      };
    tray = {
      spacing = 10;
    };

    cpu = {
      format = "  {usage}";
    };
    memory = {
      format = "  {}";
    };
# "custom/logo" = {
    #   format = "";
    #   tooltip = false;
    #   on-click = ''bemenu-run --accept-single  -n -p "Launch" --hp 4 --hf "#ffffff" --sf "#ffffff" --tf "#ffffff" '';
    # };
#
    "custom/spotify" = {
      interval = 1;
      return-type = "json";
      exec = "~/.config/waybar/modules/spotify.sh";
      exec-if = "pgrep spotify";
      escape = true;
    };
    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      format = "{icon}";
      format-icons = {
        focused = "";
        urgent = "";
        default = "";
      };
      # persistent_workspaces = {
      #   "1" = []; 
      #   "2" = [];
      #   "3" = [];
      #   "4" = [];
      # };
      disable-click = false;
    };

    "pulseaudio" = {
        format = "{icon}  {volume}% {format_source}";
        format-muted = "";
        format-icons = {
            phone = ["󱡒 " " " " "];
            default = ["" "󰖀" "󰕾"];
        };
        format-source = "Mic oN";
        format-source-muted = "Mic off";
        #scroll-step = 2;
        on-click = "pavucontrol";
      #  "on-scroll-up": "~/.dotfiles/bin/volume.sh up",
       # "on-scroll-down": "~/.dotfiles/bin/volume.sh down", 
        tooltip = false;
    };
    "network" = {
      format = "{icon} ";
      format-ethernet = "{icon}";
      format-wifi = "{essid} {icon}";
      format-alt = "{ipaddr}/{cidr} {icon}";
      format-alt-click = "click-right";
      format-icons = {
        wifi = ["󰤯" "󰤟" "󰤢" "󰤨"];
        ethernet = ["󰈀"];
        disconnected = ["󰤭"];
      };
      on-click = "kitty -e nmtui";
      tooltip = false;
    };

    "clock" = {
      interval = 60;
      format = " {:%d %b | %H:%M}";
    };

    "battery" = {
      
      tooltip = false;
    };
  };
  };

  programs.waybar.style = ''
  * {
    border: none;
    border-radius: 0;
    padding: 0;
    margin: 0;
    font-family: NotoSans Nerd Font Mono;
  }

  window#waybar {
    background: rgb(21,36,51);
    color: #ffffff;
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
    font-size: 9px;
  }
  
  #cpu {
    background: rgb(46,59,74);
    padding-top: 0;
    padding-right: 7px;
    padding-left: 5px;
    margin: 4px 0 4px 0;
    border-bottom-right-radius: 3px;
    border-top-right-radius: 3px;
  }
  #memory {
    background: rgb(46,59,74);
    padding-left: 7px;
    padding-right: 5px;
    margin: 4px 0 4px 0;
    border-bottom-left-radius: 3px;
    border-top-left-radius: 3px;
  }
  #pulseaudio {
    padding: 0 5px;
    background: rgb(46,59,74);
    margin: 4px 4px 4px 0;
    border-radius: 3px;
  }
  #network {
    padding: 0 8px 0 5px;
    background: rgb(46,59,74);
    margin: 4px 4px 4px 0;
    border-radius: 3px;
  }
  #clock {
    padding: 0 5px;
    background: rgb(46,59,74);
    margin: 4px 4px;
    border-radius: 3px;
  }
  #workspaces {
    background: rgb(46,59,74);
    border-radius: 3px;
    margin: 4px 4px;
    color: #fff;
    font-size: 7px;
  }
  #workspaces button.active {
    color: rgb(40,133,215);
  }
  
  #workspaces button {
  color: #fff;
  }
  button:hover {
    background: none;
    box-shadow: none;
    text-shadow: none;
    color: transparent;
  }
   #workspaces button:hover {
    color: rgb(40,133,215);
  }


  #language {
    margin-right: 7px;		
  }

  #battery {
    margin-left: 7px;
    margin-right: 3px;
  }  '';
}
