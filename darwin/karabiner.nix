{ config, pkgs, lib, ... }:
let
  swap = from: to: {
    type = "basic";
    from = {
      key_code = from;
      modifiers = { optional = [ "any" ]; };
    };
    to = [{ key_code = to; }];
    conditions = [{
      type = "frontmost_application_unless";
      bundle_identifiers = [
        "^com\\.apple\\.Terminal$"
        "^com\\.utmapp\\.utm$"
        "^org\\.alacritty$"
      ];
      file_paths = [ "/etc/profiles/per-user/felix/bin/alacritty" ];
    }];
  };
in {
  home.file.karabiner = {
    target = ".config/karabiner/assets/complex_modifications/control-command.json";
    text = builtins.toJSON {
      title = "Control <-> Command";
      rules = [{
        description = "Swap Command and Control";
        manipulators = [
          (swap "left_command" "left_control")
          (swap "left_control" "left_command")
        ];
      }];
    };
  };
}
