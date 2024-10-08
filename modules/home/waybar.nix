{config, pkgs, ...}:
{
  programs.waybar.enable = true;
   
  programs.waybar.settings = {
  mainBar = {
    layer = "top";
    position = "top";
    height = 20;
    margin-left = 5;
    margin-right = 5;
    margin-top = 5;
    # spacing = 10;
    #output = [
      #"eDP-1"
    #];

    modules-left = [ "sway/workspaces" "sway/mode" ];
    modules-center = [ "custom/spotify" ];
    modules-right = [ "custom/vpn" "custom/docker" "memory" "cpu" "network" "battery" "pulseaudio" "clock" ];

    media = {
      format = "<span style='margin-right: 5px;'>{icon}</span> {}";
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
      on-click = "kitty -e --app-id btopterm btop";
    };

    memory = {
      format = "  {}";
      on-click = "kitty -e --app-id btopterm btop";
    };

# "custom/logo" = {
    #   format = "";
    #   tooltip = false;
    #   on-click = ''bemenu-run --accept-single  -n -p "Launch" --hp 4 --hf "#ffffff" --sf "#ffffff" --tf "#ffffff" '';
    # };

    "custom/spotify" = {
      interval = 1;
      return-type = "json";
      exec = "~/.config/waybar/modules/spotify.sh";
      exec-if = "pgrep spotify";
      escape = true;
    };

    "custom/docker" = {
      format = "{}";
      return-type = "json";
      exec = "~/.config/waybar/modules/docker.sh";
      exec-if = "~/.config/waybar/modules/docker.sh status";
      interval = 3600;
    };

    "custom/vpn" = {
      format = "{icon} VPN <span color='#aaaaaa'>{}</span>";
      format-icons = {
        connected = "";
        disconnected = "x";
      };
      return-type = "json";
      exec = "~/.config/waybar/modules/vpn.sh";
      interval = 30;
    };

    "sway/workspaces" = {
      disable-scroll = true;
      format = "{name}";
      on-click = "activate";
      # format-icons = {
      #   focused = "";
      #   urgent = "";
      #   default = "";
      # };
      # persistent_workspaces = {
      #   "1" = []; 
      #   "2" = [];
      #   "3" = [];
      #   "4" = [];
      # };
      disable-click = false;
    };

    

    pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "󰖁";
        format-icons = {
            phone = ["󱡒 " " " " "];
            default = ["" "󰖀" "󰕾"];
        };
        # format-source = "Mic oN";
        # format-source-muted = "Mic off";
        #scroll-step = 2;
        on-click = "pavucontrol";
      #  "on-scroll-up": "~/.dotfiles/bin/volume.sh up",
       # "on-scroll-down": "~/.dotfiles/bin/volume.sh down", 
        tooltip = false;
    };

    network = {
      format = "{icon} ";
      format-ethernet = "{icon}";
      format-wifi = "{icon}";
      format-alt = "{essid} {ipaddr}/{cidr} {icon}";
      format-alt-click = "click-right";
      format-icons = {
        wifi = ["󰤯" "󰤟" "󰤢" "󰤨"];
        ethernet = ["󰈀"];
        disconnected = ["󰤭"];
      };
      on-click = "iwgtk -e app-id iwgtkfloat";
      tooltip = false;
    };

    clock = {
      interval = 60;
      format = " {:%a %d %b %H:%M}";
      timezone = "Europe/Stockholm";
    };

    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon}";
      format-charging = "󰁹 {capacity}%";
      format-plugged = "󰁹";
      format-alt = "{icon}  {capacity}%";
      format-full = "󰁹";
      format-icons = ["󰁺" "󰁼" "󰁾" "󰂀"];
    };
  };
  };

  programs.waybar.style = ''
  @define-color widgetBG rgb (100,100,154);
  /*@define-color widgetBG transparent; */
  * {
    border: none;
    border-radius: 0;
    padding: 0;
    margin: 0;
    /* text-shadow: 1px 1px 1px #000000; */
  }

  window#waybar {
    /* background: rgba(0,0,0, 0.2); */
    background: rgba(21,36,51, 0.6);
    color: #ffffff;
    text-shadow: 3px 3px 3px rgba(0,0,0, 0.5);
    border-radius: 5px;
    /* border-bottom-right-radius: 5px; */
    font-size: 12px;
  }
  
  #cpu {
    padding-top: 0;
    padding-right: 10px;
    padding-left: 10px;
    margin: 4px 4px 4px 0;
    border-bottom-right-radius: 3px;
    border-top-right-radius: 3px;
  }

  #memory {
    padding-right: 10px;
    padding-left: 10px;   margin: 4px 0 4px 0;
    border-bottom-left-radius: 3px;
    border-top-left-radius: 3px;
  }

  #pulseaudio {
    padding: 0 5px;
    margin: 4px 4px 4px 0;
    border-radius: 3px;
  }

  #network {
    padding-right: 10px;
    padding-left: 10px;
    margin: 4px 0 4px 0;
    border-bottom-left-radius: 3px;
    border-top-left-radius: 3px;
  }

   #battery {
    padding-top: 0;
    padding-right: 10px;
    padding-left: 10px;
    margin: 4px 0 4px 0;
    border-bottom-right-radius: 3px;
    border-top-right-radius: 3px;
  }
  #battery.plugged {
    color: #3ce042;

  }

  #clock {
    padding-right: 10px;
    padding-left: 10px;
    margin: 4px 4px;
    border-radius: 3px;
  }

  button:hover {
    background: none;
    box-shadow: none;
    text-shadow: none;
    color: transparent;
  }

  #workspaces button {
    background: @widgetBG;
    color: #fff;
    font-size: 12px;
  }

  #workspaces button {
    border: 1px solid transparent;
    margin-top: 4px;
    margin-bottom: 4px;
    padding-left: 7px;
    padding-right: 7px;
    color: #fff;
  }
  
  #workspaces button.focused {
    background-color: #0077ed;
  } 

  #workspaces button:hover {
    border: 1px solid #0077ed;
  }
  #workspaces button:first-child {
    margin-left: 4px;
    border-bottom-left-radius: 3px;
    border-top-left-radius: 3px;
  }
  #workspaces button:last-child {
    border-bottom-right-radius: 3px;
    border-top-right-radius: 3px;
  }
  #workspaces button:first-child:hover {
    border-bottom-left-radius: 3px;
    border-top-left-radius: 3px;
  }
   #workspaces button:last-child:hover {
    border-bottom-right-radius: 3px;
    border-top-right-radius: 3px;
  }



  
  #language {
    margin-right: 7px;		
  }

  '';
}
