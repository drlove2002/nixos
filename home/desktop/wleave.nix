{pkgs, ...}: let
  wleaveIcons = "${pkgs.wleave}/share/wleave/icons";
in {
  home.packages = with pkgs; [wleave];

  # Generate wleave JSON layout
  xdg.configFile."wleave/layout.json".text = builtins.toJSON {
    margin = 200;
    buttons-per-row = "3";
    delay-command-ms = 100;
    close-on-lost-focus = true;
    no-version-info = true;
    show-keybinds = true;
    buttons = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
        icon = "${wleaveIcons}/lock.svg";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
        icon = "${wleaveIcons}/hibernate.svg";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
        icon = "${wleaveIcons}/logout.svg";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
        icon = "${wleaveIcons}/shutdown.svg";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
        icon = "${wleaveIcons}/suspend.svg";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
        icon = "${wleaveIcons}/reboot.svg";
      }
    ];
  };

  # CSS that keeps libadwaita colors but tightens layout
  xdg.configFile."wleave/style.css".text = ''
    * {
      all: unset;
      font-family: "Maple Mono", monospace;
    }

    window {
      background-color: rgba(12, 12, 12, 0.80);
    }

    button {
      color: var(--view-fg-color);
      background-color: var(--view-bg-color);
      border-radius: 14px;
      border: 1px solid var(--window-border-color);
      padding: 18px;
      margin: 14px;
      background-repeat: no-repeat;
      background-position: center;
      background-size: 32%;
    }

    button label.action-name {
      font-size: 16px;
    }

    button label.keybind {
      font-size: 12px;
      font-family: monospace;
      opacity: 0.6;
    }

    button:hover,
    button:focus {
      color: var(--accent-color);
      background-color: var(--window-bg-color);
    }

    button:active {
      color: var(--accent-fg-color);
      background-color: var(--accent-bg-color);
    }
  '';
}
