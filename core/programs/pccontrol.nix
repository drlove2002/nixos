{pkgs, ...}: let
  webPort = "7680";
  termPort = "7681";
  lanIp = "192.168.1.178";
  phoneIp = "192.168.1.110";

  # Shared nginx access control — phone + localhost only
  onlyPhone = ''
    allow ${phoneIp};
    allow 127.0.0.1;
    deny all;
  '';

  controlServer = pkgs.writeText "pccontrol_server.py" ''
    #!/usr/bin/env python3
    import http.server
    import json
    import os
    import subprocess

    WEB_PORT = int(os.environ.get("PCCONTROL_WEB_PORT", ${webPort}))

    ACTIONS = {
        "lock":     ["hyprlock"],
        "logout":   ["hyprctl", "dispatch", "exit"],
        "suspend":  ["systemctl", "suspend"],
        "reboot":   ["systemctl", "reboot"],
        "shutdown": ["systemctl", "poweroff"],
    }

    def movieshare_active():
        r = subprocess.run(["systemctl", "is-active", "samba-smbd"],
                           capture_output=True, text=True)
        return r.stdout.strip() == "active"

    HTML_BYTES = """<!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>PC Control</title>
      <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body {
          background: #1F1F28;
          color: #DCD7BA;
          font-family: system-ui, -apple-system, sans-serif;
          display: flex;
          flex-direction: column;
          height: 100dvh;
          overflow: hidden;
        }
        header {
          background: #2A2A37;
          border-bottom: 1px solid #363646;
          padding: 10px 16px;
          display: flex;
          align-items: center;
          gap: 12px;
          flex-shrink: 0;
          flex-wrap: wrap;
        }
        h1 {
          font-size: 14px;
          font-weight: 600;
          color: #C8C093;
          letter-spacing: 0.05em;
          text-transform: uppercase;
          margin-right: auto;
        }
        .btn {
          border: none;
          border-radius: 6px;
          padding: 7px 14px;
          font-size: 13px;
          font-weight: 600;
          cursor: pointer;
          transition: opacity 0.15s, transform 0.1s;
          color: #1F1F28;
        }
        .btn:hover { opacity: 0.85; }
        .btn:active { transform: scale(0.96); }
        .btn-lock     { background: #7E9CD8; }
        .btn-logout   { background: #957FB8; }
        .btn-suspend  { background: #76946A; }
        .btn-reboot   { background: #FFA066; }
        .btn-shutdown { background: #C34043; color: #DCD7BA; }
        .btn-movieshare-on  { background: #E6C384; }
        .btn-movieshare-off { background: #54546D; color: #DCD7BA; }
        .separator { width: 1px; height: 22px; background: #363646; }
        iframe {
          flex: 1;
          border: none;
          width: 100%;
          display: block;
          background: #1F1F28;
        }
        dialog {
          background: #2A2A37;
          border: 1px solid #363646;
          border-radius: 10px;
          color: #DCD7BA;
          padding: 24px;
          max-width: 320px;
          width: 90%;
        }
        dialog::backdrop { background: rgba(0,0,0,0.6); }
        dialog p { margin-bottom: 18px; font-size: 15px; line-height: 1.4; }
        .dialog-btns { display: flex; gap: 10px; justify-content: flex-end; }
        .dialog-btns .btn { padding: 8px 18px; font-size: 14px; }
        .btn-cancel { background: #363646; color: #DCD7BA; }
      </style>
    </head>
    <body>
      <header>
        <h1>PC Control</h1>
        <button class="btn btn-lock"     onclick="act('lock')">Lock</button>
        <button class="btn btn-logout"   onclick="confirm_act('logout','Log out of the current session?')">Logout</button>
        <button class="btn btn-suspend"  onclick="act('suspend')">Suspend</button>
        <button class="btn btn-reboot"   onclick="confirm_act('reboot','Reboot the system?')">Reboot</button>
        <button class="btn btn-shutdown" onclick="confirm_act('shutdown','Shut down the system?')">Shutdown</button>
        <div class="separator"></div>
        <button class="btn btn-movieshare-off" id="ms-btn" onclick="toggleMovieshare()">&#9654; Movieshare</button>
      </header>
      <iframe src="/terminal/" title="Terminal" allow="clipboard-read; clipboard-write"></iframe>

      <dialog id="dlg">
        <p id="dlg-msg"></p>
        <div class="dialog-btns">
          <button class="btn btn-cancel" onclick="document.getElementById('dlg').close()">Cancel</button>
          <button class="btn" id="dlg-confirm" onclick="doAct()">Confirm</button>
        </div>
      </dialog>

      <script>
        let pendingAction = null;

        function act(action) {
          fetch('/action', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({action})
          });
        }

        function confirm_act(action, msg) {
          pendingAction = action;
          document.getElementById('dlg-msg').textContent = msg;
          const btn = document.getElementById('dlg-confirm');
          btn.className = 'btn btn-' + action;
          btn.textContent = action.charAt(0).toUpperCase() + action.slice(1);
          document.getElementById('dlg').showModal();
        }

        function doAct() {
          document.getElementById('dlg').close();
          if (pendingAction) act(pendingAction);
          pendingAction = null;
        }

        function setMovieshareBtn(active) {
          const btn = document.getElementById('ms-btn');
          if (active) {
            btn.className = 'btn btn-movieshare-on';
            btn.textContent = '\u23F9 Movieshare';
          } else {
            btn.className = 'btn btn-movieshare-off';
            btn.textContent = '\u25B6 Movieshare';
          }
        }

        function toggleMovieshare() {
          fetch('/movieshare', { method: 'POST' })
            .then(r => r.json())
            .then(d => setMovieshareBtn(d.active));
        }

        fetch('/movieshare')
          .then(r => r.json())
          .then(d => setMovieshareBtn(d.active));
      </script>
    </body>
    </html>
    """.encode()

    class Handler(http.server.BaseHTTPRequestHandler):
        def log_message(self, fmt, *args):
            pass  # silence access log

        def send_json(self, data):
            body = json.dumps(data).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)

        def do_GET(self):
            if self.path == "/":
                self.send_response(200)
                self.send_header("Content-Type", "text/html; charset=utf-8")
                self.send_header("Content-Length", str(len(HTML_BYTES)))
                self.end_headers()
                self.wfile.write(HTML_BYTES)
            elif self.path == "/movieshare":
                self.send_json({"active": movieshare_active()})
            else:
                self.send_error(404)

        def do_POST(self):
            if self.path == "/action":
                length = int(self.headers.get("Content-Length", 0))
                data = json.loads(self.rfile.read(length))
                action = data.get("action", "")
                cmd = ACTIONS.get(action)
                if cmd:
                    subprocess.Popen(cmd, env=os.environ)
                    self.send_response(200)
                    self.send_header("Content-Type", "application/json")
                    self.end_headers()
                    self.wfile.write(b'{"ok":true}')
                else:
                    self.send_error(400, "Unknown action")
            elif self.path == "/movieshare":
                currently = movieshare_active()
                subprocess.run(["movieshare", "off" if currently else "on"], env=os.environ)
                self.send_json({"active": movieshare_active()})
            else:
                self.send_error(404)

    if __name__ == "__main__":
        with http.server.HTTPServer(("0.0.0.0", WEB_PORT), Handler) as httpd:
            print(f"pccontrol web server listening on port {WEB_PORT}")
            httpd.serve_forever()
  '';

  pccontrolScript = pkgs.writeShellScriptBin "pccontrol" ''
    case "$1" in
      on)
        ${pkgs.ttyd}/bin/ttyd -p ${termPort} -W bash >/dev/null 2>&1 &
        echo $! > /tmp/pccontrol_term.pid
        python3 ${controlServer} >/dev/null 2>&1 &
        echo $! > /tmp/pccontrol_web.pid
        echo "PC Control ON — http://$(hostname).local"
        ;;
      off)
        for f in /tmp/pccontrol_term.pid /tmp/pccontrol_web.pid; do
          kill $(<"$f") 2>/dev/null && rm "$f"
        done
        echo "PC Control OFF"
        ;;
      *)
        echo "Usage: pccontrol on|off"
        ;;
    esac
  '';
in {
  networking.firewall.allowedTCPPorts = [80];
  networking.firewall.allowedUDPPorts = [53];

  # Local DNS so the phone can resolve "nixos" / "nixos.local" without mDNS
  services.dnsmasq = {
    enable = true;
    settings = {
      address = ["/nixos/${lanIp}" "/nixos.local/${lanIp}"];
      server = ["8.8.8.8" "1.1.1.1"];
      interface = ["enp3s0" "lo"];
      bind-interfaces = true;
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."pccontrol" = {
      listen = [{addr = "0.0.0.0"; port = 80;}];
      locations."/" = {
        proxyPass = "http://127.0.0.1:${webPort}";
        extraConfig = "proxy_read_timeout 3600;\n${onlyPhone}";
      };
      locations."/terminal/" = {
        proxyPass = "http://127.0.0.1:${termPort}/";
        extraConfig = ''
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_read_timeout 3600;
          ${onlyPhone}
        '';
      };
    };
  };

  environment.systemPackages = [pkgs.ttyd pccontrolScript];
}
