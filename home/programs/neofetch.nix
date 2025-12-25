{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "builtin";
        height = 12;
        width = 30;
      };
      display = {
        separator = "  ";
      };
      modules = [
        "break"
        {
          type = "custom";
          format = "┌─────────────────────── System ──────────────────────┐";
        }
        "break"
        {
          key = "     OS           ";
          keyColor = "red";
          type = "os";
        }
        {
          key = "    󰌢 Machine      ";
          keyColor = "green";
          type = "host";
        }
        {
          key = "     Kernel       ";
          keyColor = "magenta";
          type = "kernel";
        }
        {
          key = "    󰅐 Uptime       ";
          keyColor = "red";
          type = "uptime";
        }
        "break"
        {
          type = "custom";
          format = "├─────────────────────── Display ─────────────────────┤";
        }
        "break"
        {
          key = "    󰍹 Resolution   ";
          keyColor = "yellow";
          type = "display";
          compactType = "original-with-refresh-rate";
        }
        {
          key = "     WM           ";
          keyColor = "blue";
          type = "wm";
        }
        {
          key = "     DE           ";
          keyColor = "green";
          type = "de";
        }
        "break"
        {
          type = "custom";
          format = "├──────────────────── Software ──────────────────────┤";
        }
        "break"
        {
          key = "    󰏖 Packages     ";
          keyColor = "white";
          type = "packages";
        }
        {
          key = "     Shell        ";
          keyColor = "cyan";
          type = "shell";
        }
        {
          key = "     Terminal     ";
          keyColor = "red";
          type = "terminal";
        }
        "break"
        {
          type = "custom";
          format = "├────────────────────── Hardware ─────────────────────┤";
        }
        "break"
        {
          key = "    󰻠 CPU          ";
          keyColor = "yellow";
          type = "cpu";
        }
        {
          key = "    󰍛 GPU          ";
          keyColor = "blue";
          type = "gpu";
        }
        {
          key = "    󰑭 Memory       ";
          keyColor = "magenta";
          type = "memory";
        }
        "break"
        {
          type = "custom";
          format = "└──────────────────────────────────────────────────────┘";
        }
        "break"
        {
          paddingLeft = 18;
          symbol = "circle";
          type = "colors";
        }
      ];
    };
  };
}
