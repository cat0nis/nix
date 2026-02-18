{ config, pkgs, lib, ...}:

{
  #  #home.file.".config/hypr/hyprland.conf".source = ../hyprland.conf;
  home.file.".config/hypr/wallpaper.jpg".source = ./wallpaper.jpg;
  home.file.".config/hypr/lockpaper.jpg".source = ./lockpaper.jpg;

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    hyprpaper
    hyprshot
    grim
    pwvucontrol
    polybar-pulseaudio-control

    fuzzel
  ];
  
  services.polkit-gnome.enable = true;
  services.mako.enable=true;

  catppuccin.swaylock.enable = false;
  programs.swaylock.package = pkgs.swaylock-effects;
  programs.swaylock = {
    enable = true;
    settings = {
      show-failed-attempts = true;
      ignore-empty-password = true;
      hide-keyboard-layout = true;
      indicator-caps-lock = true;
      
      # color = "20262CE6";
      font = "JetBrainsMono Nerd Font";
      font-size =  18;

      key-hl-color = lib.mkForce "74DD91"; 
      caps-lock-key-hl-color = lib.mkForce "75DBE1"; 
      bs-hl-color = lib.mkForce "DB86BA"; 
      caps-lock-bs-hl-color = lib.mkForce "DB86BA"; 
	
	    # Indicator 
      indicator-radius = 120 ;
      indicator-thickness = 10; 
	
	# Inside Circle Colors 
      inside-color = "00000000"; 
      inside-clear-color = "00000000"; 
      inside-caps-lock-color = "00000000"; 
      inside-ver-color = "75DBE1"; 
      inside-wrong-color = "DB86BA"; 
	
	# Layout Colors 
      layout-bg-color = "9EE9EA"; 
      layout-border-color = "9EE9EA"; 
      layout-text-color = "20262C"; 
	
	# Line Colors 
      line-color = "20262C"; 
      line-clear-color = "DB86BA"; 
      line-caps-lock-color = "20262C"; 
      line-ver-color = "20262C"; 
      line-wrong-color = "20262C"; 
	
	# Ring Colors 
      ring-color = "9EE9EA"; 
      ring-clear-color = "20262C"; 
      ring-caps-lock-color = "B4A1DB"; 
      ring-ver-color = "75DBE1"; 
      ring-wrong-color = "DB86BA"; 
	
	# Separator Color 
      separator-color = "20262C"; 
	
	# Text Colors 
       text-color = "F1FCF9"; 
       text-clear-color = "F1FCF9"; 
       text-caps-lock-color = "F1FCF9"; 
       text-ver-color = "20262C"; 
       text-wrong-color = "20262C";
      
      effect-pixelate = 10;
      clock = true;
      timestr = "%-H:%M:%S";
      datestr = "";
      indicator = true;
      fade-in = 0.1;
      image = "${config.home.homeDirectory}/.config/hypr/lockpaper.jpg";
    };

  };
  #security.pam.services.swaylock = {};

  programs.fuzzel = {
    enable = true;
    settings = {
      colors = {
          background="1e1e2edd";
          text="cdd6f4ff";
          match="f38ba8ff";
          selection="585b70ff";
          selection-match="f38ba8ff";
          selection-text="cdd6f4ff";
          border="b4befeff";
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [

        {
          monitor = "eDP-1";
          path = "${config.home.homeDirectory}/.config/hypr/wallpaper.jpg";
          fit_mode = "cover";
        }

      ];
      splash = false;
    };
};


  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;

    settings = {

      monitor = [
        "eDP-1,1920x1080@144,0x0,1"
        ",prefered,-1920x0,1"
      ];

      workspace = "eDP-1,1";

      input = {
        kb_layout="pt";
        follow_mouse=1;
        natural_scroll=false;
	      force_no_accel=0;
        touchpad = {
          natural_scroll=true;
        };
      };

      gesture = [
          "3,horizontal,workspace"
      ];

      #-- General ----------------------------------------------------
      # General settings like MOD key, Gaps, Colors, etc.
      general = {
          gaps_in=5;
          gaps_out=8;

          border_size=2;
          "col.active_border"="0xFF56B6C2";
          "col.inactive_border"="0xFF343A40";

          #nostarship_focus_fallback = true;
      };

      #-- Decoration ----------------------------------------------------
      # Decoration settings like Rounded Corners, Opacity, Blur, etc.
      decoration = {
        rounding=8;

        active_opacity=1.0;
        inactive_opacity=1.0;
        fullscreen_opacity=1.0;

        blur = {
          enabled=true;
          size=1;
          passes=4;
          ignore_opacity=true;
          new_optimizations=true;
        };
      # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
      # if you want heavy blur, you need to up the blur_passes.
      # the more passes, the more you can up the blur_size without noticing artifacts.
      };

      #-- Animations ----------------------------------------------------
      animations =  {
        enabled = 1;
        animation = [
          "windows,1,5,default"
          "border,1,10,default"
          "fade,1,8,default"
          "workspaces,1,3,default"
        ];
      };

      misc =  {
        mouse_move_enables_dpms=1;
        disable_hyprland_logo = true;
        vfr=true ;
      };

      "$backlight" =  "${config.home.homeDirectory}/.config/hypr/scripts/brightness";
      "$volume" = "";
      windowrule = [
        "border_size 0, match:float true" # remove borders from floating 

        "match:class org.telegram.desktop, float on, size (monitor_w*0.25) (monitor_h*0.5)"
        "match:title ^(Picture-in-Picture|Firefox)$, float on, size 800 450, pin on"
        "match:class mpv, size (monitor_w*0.7) (monitor_h*0.7)"
        "match:class ^(Spotify)$, opacity 0.8"
        "match:class kitty, tile on, size  (monitor_w*0.7) (monitor_h*0.7), opacity 0.8"
      ];

      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      bind = [
        # -- mirror screen toggle --
        "SUPERALT,m,exec,hyprctl keyword monitor ,prefered,-1920x0,1,mirror, eDP-1"
        "SUPERALT,n,exec,hyprctl keyword monitor ,prefered,-1920x0,1"
        

        # -- Terminal --
        "SUPER,T,exec,kitty"

        # -- Launcher --
        "SUPER,D,exec, fuzzel"
        
        
        # -- Rofi --
        #"SUPER,D,exec,$launcher"
        #"SUPER,X,exec,$powermenu"
        #"SUPER,S,exec,$screenshot"


        # --- Lockscreen ---
        "SUPER,escape,exec, swaylock"
        
        # -- Function keys --
        ",XF86MonBrightnessUp,exec, brightnessctl set +10%" 
        ",XF86MonBrightnessDown,exec, brightnessctl set 10%-" 
        ",XF86AudioRaiseVolume,exec, pulseaudio-control --volume-step 5 up"
        ",XF86AudioLowerVolume,exec, pulseaudio-control --volume-step 5 down" 
        ",XF86AudioMute,exec,pulseaudio-control togmute" 
        ",XF86AudioMicMute,exec,pulseaudio-control --node-type input togmute" 
        ",XF86AudioNext,exec,mpc next" 
        ",XF86AudioPrev,exec,mpc prev" 
        ",XF86AudioPlay,exec,mpc toggle" 
        ",XF86AudioStop,exec,mpc stop" 
        
        # -- Hyprland --
        
        "SUPERSHIFT,Q,killactive,"
        #"SUPER,C,killactive,"
        "CTRLALT,Delete,exit,"
        "SUPER,F,fullscreen,"
        "SUPER,Space,togglefloating,"
        "SUPER,M,pseudo,"
        
        
        # Focus
        "SUPER,left,movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,down,movefocus,d"
        
        # Move
        "SUPERSHIFT,left,movewindow,l"
        "SUPERSHIFT,right,movewindow,r"
        "SUPERSHIFT,up,movewindow,u"
        "SUPERSHIFT,down,movewindow,d"
        
        # Resize
        "SUPERCTRL,left,resizeactive,-20 0"
        "SUPERCTRL,right,resizeactive,20 0"
        "SUPERCTRL,up,resizeactive,0 -20"
        "SUPERCTRL,down,resizeactive,0 20"
        
        # Groups
        "ALT, t, togglegroup"
        
        # Workspaces
        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        
        # Send to Workspaces
        "SUPERSHIFT,1,movetoworkspace,1"
        "SUPERSHIFT,2,movetoworkspace,2"
        "SUPERSHIFT,3,movetoworkspace,3"
        "SUPERSHIFT,4,movetoworkspace,4"
        "SUPERSHIFT,5,movetoworkspace,5"
        "SUPERSHIFT,6,movetoworkspace,6"
        
        # Send workspace to monitor
        "SUPERALT,0,movecurrentworkspacetomonitor, 0"
        "SUPERALT,1,movecurrentworkspacetomonitor, 1"
        
        "SUPERSHIFT,0, movetoworkspace, special"
        "SUPERSHIFT,9,movetoworkspace, special:discord"
        
        "SUPER,0, togglespecialworkspace"
        "SUPER,49, togglespecialworkspace, discord"

        "ALT, Tab, cyclenext, bind = ALT, Tab, bringactivetotop, "

        # Screenshots
        ", print, exec, grim $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')"
        "CTRL, print, exec, grim -g '$(slurp -o)' $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')"
        "CTRL SHIFT, print, exec, grim -g '$(slurp)' $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')"
        "SUPERSHIFT, S, exec, hyprshot -m region --clipboard-only"
      ];

      exec-once = [
#        "~/.config/hypr/scripts/portal"
#        "dbus-daemon --session --address=unix:path=$XDG_RUNTIME_DIR/bus"
#        "dbus-update-activation-environment --all WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

#        "hyprpanel"
        #"~/.config/hypr/scripts/startup"
        "kitty &"
        "nm-applet &"
#        "swww-daemon"
        "discord &"
        "waybar &"
        "hyprpaper &"
      ];
    };
  };


}
