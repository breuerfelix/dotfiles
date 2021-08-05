{ config, pkgs, lib, ... }: {
  home.file.spacebar = {
    executable = true;
    target = ".config/spacebar/spacebarrc";
    text = ''
      #!/usr/bin/env sh

      spacebar -m config position                    top
      spacebar -m config display                     main
      spacebar -m config height                      26
      spacebar -m config title                       on
      spacebar -m config spaces                      on
      spacebar -m config clock                       on
      spacebar -m config power                       on
      spacebar -m config padding_left                20
      spacebar -m config padding_right               20
      spacebar -m config spacing_left                25
      spacebar -m config spacing_right               15
      spacebar -m config text_font                   "Menlo:Regular:12.0"
      spacebar -m config icon_font                   "Font Awesome 5 Free:Solid:12.0"
      spacebar -m config background_color            0xff202020
      spacebar -m config foreground_color            0xffa8a8a8
      spacebar -m config power_icon_color            0xffcd950c
      spacebar -m config battery_icon_color          0xffd75f5f
      spacebar -m config dnd_icon_color              0xffa8a8a8
      spacebar -m config clock_icon_color            0xffa8a8a8
      spacebar -m config power_icon_strip             
      spacebar -m config space_icon                  •
      spacebar -m config space_icon_color            0xffffab91
      spacebar -m config space_icon_color_secondary  0xff78c4d4
      spacebar -m config space_icon_color_tertiary   0xfffff9b0
      spacebar -m config space_icon_strip            1 2 3 4 5 6 7 8 9 10
      spacebar -m config spaces_for_all_displays     on
      spacebar -m config clock_icon                  
      spacebar -m config dnd_icon                    
      spacebar -m config clock_format                "%d/%m/%y %R"
      spacebar -m config right_shell                 on
      spacebar -m config right_shell_icon            
      spacebar -m config right_shell_command         "whoami"

      echo "spacebar configuration loaded.."
    '';
  };
}
