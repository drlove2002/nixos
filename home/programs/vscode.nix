{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscodium;
    mutableExtensionsDir = true;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions =
        with pkgs.open-vsx;
        [
          vscodevim.vim
          cweijan.dbclient-jdbc
          fill-labs.dependi
          usernamehw.errorlens
          tamasfe.even-better-toml
          ecmel.vscode-html-css
          oderwat.indent-rainbow
          k--kato.intellij-idea-keybindings
          jnoortheen.nix-ide
          mechatroner.rainbow-csv
          charliermarsh.ruff
          rust-lang.rust-analyzer
          bradlc.vscode-tailwindcss
          gruntfuggly.todo-tree
          vscode-icons-team.vscode-icons
          zxh404.vscode-proto3
          davidanson.vscode-markdownlint
          dbaeumer.vscode-eslint
          metaphore.kanagawa-vscode-color-theme
        ]
        ++ (with pkgs.vscode-marketplace; [
          github.vscode-github-actions
          github.copilot-chat
          ms-vscode.hexeditor
          ms-pyright.pyright
          ms-python.python
          brettm12345.nixfmt-vscode
          ryu1kn.partial-diff
          #   vadimcn.vscode-lldb
        ]);

      userSettings = builtins.fromJSON ''
        {
            "workbench.iconTheme": "vscode-icons",
            "editor.inlineSuggest.enabled": true,
            "explorer.confirmDelete": false,
            "indentRainbow.indicatorStyle": "light",
            "indentRainbow.lightIndicatorStyleLineWidth": 4,
            "rust-analyzer.check.command": "clippy",
            "github.copilot.enable": {
                "*": true,
                "plaintext": false,
                "markdown": true,
                "scminput": false
            },
            "vim.enableNeovim": true,
            "vim.easymotion": true,
            "vim.useSystemClipboard": true,
            "vim.replaceWithRegister": true,
            "vim.foldfix": true,
            "vim.smartRelativeLine": true,
            "vim.targets.enable": true,
            "emmet.showSuggestionsAsSnippets": true,
            "editor.formatOnSave": true,
            "protoc": {
                "compile_on_save": false,
                "options": [
                    "--proto_path=protos/"
                ]
            },
            "editor.wordWrap": "on",
            "editor.cursorBlinking": "smooth",
            "workbench.reduceMotion": "on",
            "terminal.integrated.smoothScrolling": true,
            "editor.mouseWheelZoom": true,
            "explorer.confirmDragAndDrop": false,
            "[dart]": {
                "editor.formatOnSave": true,
                "editor.formatOnType": true,
                "editor.rulers": [
                    120
                ],
                "editor.selectionHighlight": false,
                "editor.suggestSelection": "first",
                "editor.tabCompletion": "onlySnippets",
                "editor.wordBasedSuggestions": "off"
            },
            "editor.stickyScroll.enabled": false,
            "vsicons.dontShowNewVersionMessage": true,
            "lldb.suppressUpdateNotifications": true,
            "database-client.autoSync": true,
            "debug.onTaskErrors": "showErrors",
            "chat.editing.confirmEditRequestRetry": false,
            "python.analysis.diagnosticSeverityOverrides": {
                "reportMissingModuleSource": "none"
            },
            "python.languageServer": "Default",
            "problems.showCurrentInStatus": true,
            "python.analysis.languageServerMode": "full",
            "python.analysis.diagnosticMode": "workspace",
            "python.analysis.typeCheckingMode": "basic",
            "security.workspace.trust.untrustedFiles": "open",
            "window.newWindowDimensions": "fullscreen",
            "chat.editing.confirmEditRequestRemoval": false,
            "tailwindCSS.experimental.configFile": "./src/index.css",
            "tailwindCSS.includeLanguages": {
                "javascript": "javascript",
                "javascriptreact": "javascript",
                "typescript": "typescript",
                "typescriptreact": "typescript"
            },
            "tailwindCSS.emmetCompletions": true,
            "editor.quickSuggestions": {
                "other": "on",
                "comments": "on",
                "strings": "on"
            },
            "terminal.integrated.enableMultiLinePasteWarning": "never",
            "postman.mcp.notifications.postmanMCP": false,
            "terminal.external.linuxExec": "kitty",
            "terminal.integrated.defaultProfile.linux": "zsh",
            "[nix]": {
                "editor.defaultFormatter": "brettm12345.nixfmt-vscode"
            },
            "git.autofetch": true,
            "workbench.colorTheme": "Kanagawa Dragon",
            "[markdown]": {
                "editor.formatOnSave": true,
                "editor.formatOnPaste": true
            }
        }
      '';
    };

  };
}
