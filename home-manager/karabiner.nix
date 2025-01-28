{ ... }:
let
  swapIfNotTerminal = from: to: {
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
        "^com\\.mitchellh\\.ghostty$"
      ];
      file_paths = [ "/etc/profiles/per-user/felix/bin/alacritty" ];
    }];
  };

  swapIfInternal = from: to: {
    type = "basic";
    from = {
      key_code = from;
      modifiers = { optional = [ "any" ]; };
    };
    to = [{ key_code = to; }];
    conditions = [{
      type = "device_if";
      identifiers = [{ is_built_in_keyboard = true; }];
    }];
  };

  swap = from: to: {
    type = "basic";
    from = {
      key_code = from;
      modifiers = { optional = [ "any" ]; };
    };
    to = [{ key_code = to; }];
    conditions = [ ];
  };
in {
  home.file.karabiner = {
    target = ".config/karabiner/assets/complex_modifications/nix.json";
    text = builtins.toJSON {
      title = "Nix Managed";
      rules = [{
        description = "Modifications managed by Nix";
        manipulators = [
          # for "normal" keyboards
          (swapIfNotTerminal "caps_lock" "left_command")
          (swap "caps_lock" "left_control")

          # ensure CMD is ALT for internal keyboard
          (swapIfInternal "left_command" "left_option")
          (swapIfInternal "left_option" "left_command")

          # for ctrl + t: new tab in browser
          (swapIfNotTerminal "left_control" "left_command")
          (swapIfNotTerminal "left_command" "left_control")

          # for umlaute
          (swapIfInternal "right_command" "right_option")
        ];
      }];
    };
  };
}
