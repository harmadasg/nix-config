{
  systemSettings,
  lib,
  ...
}: let
  monitors = systemSettings.monitors;

  findMainMonitor = let
    matches = builtins.filter (m: m.name == "main") monitors;
  in
    if matches == []
    then builtins.head monitors
    else builtins.head matches;

  hyprlandMonitors =
    builtins.map
    (
      m:
        if m.enabled
        then "${m.output}, ${m.width}x${m.height}@${m.refresh}, ${m.x}x${m.y}, ${m.scale}"
        else "${m.output}, disable"
    )
    monitors;
in {
  options.display = {
    monitors = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      readOnly = true;
      default = hyprlandMonitors;
      description = "Hyprland-style monitor strings generated from structured monitor definitions.";
    };

    mainMonitor = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
      default = findMainMonitor;
      description = "Full attribute set of the monitor named 'main', or the first monitor as fallback.";
    };
  };
}

