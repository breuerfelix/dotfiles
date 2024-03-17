{ inputs, ... }:
let folder = "${inputs.sketchybar}/.config/sketchybar";
in {
  home.file = {
    icons = {
      target = ".config/sketchybar/icons.sh";
      text = builtins.readFile "${folder}/icons.sh";
    };
    colors = {
      target = ".config/sketchybar/colors.sh";
      text = builtins.readFile "${folder}/colors.sh";
    };
    icon-map = {
      executable = true;
      target = ".config/sketchybar/plugins/icon_map.sh";
      text = builtins.readFile "${folder}/plugins/icon_map.sh";
    };
    sketchybar = {
      executable = true;
      target = ".config/sketchybar/sketchybarrc";
      text = ''
        #!/bin/bash

        CONFIG_DIR="${folder}"
        source "$CONFIG_DIR/colors.sh" # Loads all defined colors
        source "$CONFIG_DIR/icons.sh" # Loads all defined icons

        ITEM_DIR="$CONFIG_DIR/items" # Directory where the items are configured
        PLUGIN_DIR="$CONFIG_DIR/plugins" # Directory where all the plugin scripts are stored

        FONT="SF Pro" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
        PADDINGS=3 # All paddings use this value (icon, label, background)

        # Unload the macOS on screen indicator overlay for volume change
        launchctl unload -F /System/Library/LaunchAgents/com.apple.OSDUIHelper.plist > /dev/null 2>&1 &

        # Setting up the general bar appearance of the bar
        bar=(
          height=39
          color=$BAR_COLOR
          border_width=0
          border_color=$BAR_BORDER_COLOR
          shadow=off
          position=top
          sticky=on
          padding_right=12
          padding_left=12
          y_offset=0
          margin=0
          topmost=window
          notch_width=200
          corner_radius=0
        )

        sketchybar --bar "''${bar[@]}"

        # Setting up default values
        defaults=(
          updates=when_shown
          icon.font="$FONT:Bold:14.0"
          icon.color=$ICON_COLOR
          icon.padding_left=$PADDINGS
          icon.padding_right=$PADDINGS
          label.font="$FONT:Semibold:13.0"
          label.color=$LABEL_COLOR
          label.padding_left=$PADDINGS
          label.padding_right=$PADDINGS
          padding_right=$PADDINGS
          padding_left=$PADDINGS
          background.height=26
          background.corner_radius=9
          background.border_width=2
          popup.background.border_width=2
          popup.background.corner_radius=9
          popup.background.border_color=$POPUP_BORDER_COLOR
          popup.background.color=$POPUP_BACKGROUND_COLOR
          popup.blur_radius=20
          popup.background.shadow.drawing=on
        )

        sketchybar --default "''${defaults[@]}"

        # Left
        source "$ITEM_DIR/apple.sh"
        source "$ITEM_DIR/spaces.sh"
        source "$ITEM_DIR/yabai.sh"
        source "$ITEM_DIR/front_app.sh"

        # Center
        # does not work because of notch
        #source "$ITEM_DIR/spotify.sh"

        # Right
        source "$ITEM_DIR/calendar.sh"
        source "$ITEM_DIR/brew.sh"
        source "$ITEM_DIR/github.sh"
        source "$ITEM_DIR/wifi.sh"
        source "$ITEM_DIR/battery.sh"
        #source "$ITEM_DIR/volume.sh"

        # add bracket around items
        status_bracket=(
          background.color=$BACKGROUND_1
          background.border_color=$BACKGROUND_2
        )

        sketchybar --add bracket status brew github.bell wifi \
                   --set status "''${status_bracket[@]}"

        # add meetingbar
        sketchybar --add alias      MeetingBar right           \
                   --set MeetingBar background.padding_right=0  \
                                    background.padding_left=0    \
                                    update_freq=10                \
                                    icon.font="$FONT:Regular:14.0" \
                                    label.font="$FONT:Regular:14.0"

        sketchybar --hotload on

        # Forcing all item scripts to run (never do this outside of sketchybarrc)
        sketchybar --update

        echo "sketchybar configuation loaded.."
      '';
    };
  };
}
