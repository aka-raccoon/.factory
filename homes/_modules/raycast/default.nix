{
  lib,
  config,
  hostname,
  pkgs,
  ...
}:
let
  cfg = config.modules.raycast;
  scripts = "raycast/scripts";
in
{
  options.modules.raycast = {
    enable = lib.mkEnableOption "raycast";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ raycast ];

    xdg.configFile."${scripts}/build-dots.sh" = {
      text = ''
        #!/bin/bash
        # @raycast.schemaVersion 1
        # @raycast.title Build dots ◉◉◉◉
        # @raycast.mode compact
        # @raycast.packageName Raycast Scripts
        # @raycast.icon 💾
        # @raycast.currentDirectoryPath ~
        # @raycast.needsConfirmation false
        # Documentation:
        # @raycast.description Run NixOS rebuild command

        /run/current-system/sw/bin/darwin-rebuild switch --flake "git+ssh://git@github.com/aka-raccoon/.factory/#${hostname}"
      '';
      executable = true;
    };
  };
}
