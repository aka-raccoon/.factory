{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.aerospace;
  monitor = {
    office = {
      name = "dell";
      gap = 700;
    };
  };
  ws_terminal = "T";
  ws_browser = "B";
  ws_notes = "N";
in
{
  options.modules.aerospace = {
    enable = lib.mkEnableOption "aerospace";
  };
  config = lib.mkIf cfg.enable {
    services.aerospace = {
      enable = true;
      settings = {
        start-at-login = false;
        default-root-container-layout = "accordion";
        mode.main.binding = {
          alt-shift-t = "workspace ${ws_terminal}";
          alt-shift-b = "workspace ${ws_browser}";
          alt-shift-n = "workspace ${ws_notes}";
        };
        gaps = {
          outer = {
            left = [
              {
                monitor."${monitor.office.name}" = monitor.office.gap;
              }
              2
            ];
            right = [
              { monitor."${monitor.office.name}" = monitor.office.gap; }
              2
            ];

          };
        };
        workspace-to-monitor-force-assignment = {
          "${ws_terminal}" = [
            monitor.office.name
            "built-in"
          ];
          "${ws_browser}" = [
            monitor.office.name
            "built-in"
          ];
          "${ws_notes}" = [
            monitor.office.name
            "built-in"
          ];
        };
        on-window-detected = [
          {
            "if".app-id = "com.mitchellh.ghostty";
            run = "move-node-to-workspace ${ws_terminal}";
          }
          {
            "if".app-id = "com.apple.Safari";
            run = "move-node-to-workspace ${ws_browser}";
          }
          {
            "if".app-id = "inc.tana.desktop";
            run = "move-node-to-workspace ${ws_notes}";
          }
        ];
      };
    };
  };
}
