{ inputs, ... }:
let
  folder = "${inputs.sketchybar}/config/sketchybar";
in
{
  home.file.sketchybar = {
    executable = true;
    target = ".config/sketchybar/sketchybarrc";
    text = ''
      #!/usr/bin/env sh

      source "${folder}/colors.sh"
      source "${folder}/icons.sh"

      ITEM_DIR="${folder}/items" # Directory where the items are configured
      PLUGIN_DIR="${folder}/plugins" # Directory where all the plugin scripts are stored

      FONT="SF Regular" # Needs to have Regular, Bold, Semibold, Heavy and Black variants
      SPACE_CLICK_SCRIPT="yabai -m space --focus \$SID 2>/dev/null" # The script that is run for clicking on space components
      POPUP_CLICK_SCRIPT="sketchybar -m --set \"\$NAME\" popup.drawing=toggle" # The script that toggles the popup windows

      PADDINGS=3 # All paddings use this value (icon, label, background and bar paddings)
      SEGMENT_SPACING=13 # The spacing between segments

      POPUP_BORDER_WIDTH=2
      POPUP_CORNER_RADIUS=3

      SHADOW=off
      SHADOW_DISTANCE=3
      SHADOW_ANGLE=35

      # Setting up the general bar appearance and default values
      sketchybar --bar     height=39                                           \
                           corner_radius=0                                     \
                           border_width=0                                      \
                           margin=-200                                         \
                           blur_radius=0                                       \
                           position=bottom                                     \
                           padding_left=4                                      \
                           padding_right=4                                     \
                           color=0x000000                                      \
                           topmost=off                                         \
                           font_smoothing=off                                  \
                           y_offset=-32                                        \
                           shadow=off                                          \
                           notch_width=0                                       \
                                                                               \
                 --default drawing=on                                          \
                           updates=when_shown                                  \
                           label.font="$FONT:Semibold:13.0"                    \
                           icon.font="$FONT:Bold:14.0"                         \
                           icon.color=$ICON_COLOR                              \
                           label.color=$LABEL_COLOR                            \
                           icon.padding_left=$PADDINGS                         \
                           icon.padding_right=$PADDINGS                        \
                           label.padding_left=$PADDINGS                        \
                           label.padding_right=$PADDINGS                       \
                           background.padding_right=$PADDINGS                  \
                           background.padding_left=$PADDINGS                   \
                           popup.background.border_width=$POPUP_BORDER_WIDTH   \
                           popup.background.corner_radius=$POPUP_CORNER_RADIUS \
                           popup.background.border_color=$POPUP_BORDER_COLOR   \
                           popup.background.color=$POPUP_BACKGROUND_COLOR      \
                           popup.background.shadow.drawing=$SHADOW             \
                           popup.blur_radius=50                                \
                           icon.shadow.color=$SHADOW_COLOR                     \
                           icon.shadow.distance=$SHADOW_DISTANCE               \
                           icon.shadow.angle=$SHADOW_ANGLE                     \
                           icon.shadow.drawing=$SHADOW                         \
                           label.shadow.color=$SHADOW_COLOR                    \
                           label.shadow.distance=$SHADOW_DISTANCE              \
                           label.shadow.angle=$SHADOW_ANGLE                    \
                           label.shadow.drawing=$SHADOW


      # Template for the segment labels, i.e. space name, active app, date, ...
      sketchybar --add item           label_template left                          \
                 --set label_template icon.drawing=off                             \
                                      label.font="$FONT:Black:12.0"                \
                                      label.padding_right=5                        \
                                      click_script="$PLUGIN_DIR/toggle_bracket.sh" \
                                      background.padding_left=$SEGMENT_SPACING     \
                                      background.padding_right=0                   \
                                      drawing=off

      source "$ITEM_DIR/apple.sh"
      source "$ITEM_DIR/spaces.sh"
      source "$ITEM_DIR/calendar.sh"
      # source "$ITEM_DIR/github.sh"
      source "$ITEM_DIR/network.sh"
      source "$ITEM_DIR/memory.sh"

      source "$ITEM_DIR/cpu.sh"
      source "$ITEM_DIR/system.sh"
      source "$ITEM_DIR/spotify.sh"

      ############## FINALIZING THE SETUP ##############
      sketchybar --update

      ############## Animation ########################
      # sketchybar --animate sin 30 \
      #            --bar y_offset=0 \
      #                  notch_width=200 \
      #                  margin=0 \
      #                  shadow=on \
      #                  corner_radius=20 \
      #                  corner_radius=20 \
      #                  corner_radius=20 \
      #                  corner_radius=0 \
      #                  color=0x000000 \
      #                  color=0x000000 \
      #                  color=$BAR_COLOR \
      #                  blur_radius=0 \
      #                  blur_radius=0 \
      #                  blur_radius=0 \
      #                  blur_radius=50
      #
      echo "sketchybar configuation loaded.."
    '';
  };
}
