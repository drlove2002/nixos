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
          # vadimcn.vscode-lldb
        ]);

      keybindings = import ./keybindings.nix;
      userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    };

  };
}
