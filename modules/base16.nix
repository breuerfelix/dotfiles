{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.base16;
in
{
  options = {
    programs.base16 = {
      enable = mkEnableOption "base16 colors.";
      colors = mkOption {
        type = types.submodule {
          options = {
            base00 = mkOption { type = types.str; };
            base01 = mkOption { type = types.str; };
            base02 = mkOption { type = types.str; };
            base03 = mkOption { type = types.str; };
            base04 = mkOption { type = types.str; };
            base05 = mkOption { type = types.str; };
            base06 = mkOption { type = types.str; };
            base07 = mkOption { type = types.str; };
            base08 = mkOption { type = types.str; };
            base09 = mkOption { type = types.str; };
            base0A = mkOption { type = types.str; };
            base0B = mkOption { type = types.str; };
            base0C = mkOption { type = types.str; };
            base0D = mkOption { type = types.str; };
            base0E = mkOption { type = types.str; };
            base0F = mkOption { type = types.str; };
          };
        };
        default = { };
        description = ''
          Base16 colorset. TODO example
        '';
      };
      alacritty = mkOption {
        default = false;
        description = ''
          Alacritty integration.
        '';
      };
      fzf = mkOption {
        default = false;
        description = ''
          fzf integration.
        '';
      };
      dunst = mkOption {
        default = false;
        description = ''
          Dunst integration.
        '';
      };
      i3 = mkOption {
        default = false;
        description = ''
          i3 integration.
        '';
      };
      neovim = mkOption {
        default = false;
        description = ''
          Neovim integration.
        '';
      };
      neovim_airline = mkOption {
        default = false;
        description = ''
          Neovim Airline integration.
        '';
      };
      tmux = mkOption {
        default = false;
        description = ''
          Tmux integration.
        '';
      };
      xresources = mkOption {
        default = false;
        description = ''
          Xresources integration.
        '';
      };
    };
  };

  # TODO make cfg.colors available in whole config
  # error: infinite recursion encountered when using config = with cfg.color
  config = mkIf cfg.enable {
    # https://github.com/aaron-williamson/base16-alacritty/blob/master/templates/default-256.mustache
    programs.alacritty.settings.colors = with cfg.colors; mkIf cfg.alacritty {
      primary = {
        background = "0x${base00}";
        foreground = "0x${base05}";
      };
      cursor = {
        text = "0x${base00}";
        cursor = "0x${base05}";
      };
      normal = {
        black = "0x${base00}";
        red = "0x${base08}";
        green = "0x${base0B}";
        yellow = "0x${base0A}";
        blue = "0x${base0D}";
        magenta = "0x${base0E}";
        cyan = "0x${base0C}";
        white = "0x${base05}";
      };
      bright = {
        black = "0x${base03}";
        red = "0x${base08}";
        green = "0x${base0B}";
        yellow = "0x${base0A}";
        blue = "0x${base0D}";
        magenta = "0x${base0E}";
        cyan = "0x${base0C}";
        white = "0x${base07}";
      };
      indexed_colors = [
        { index = 16; color = "0x${base09}"; }
        { index = 17; color = "0x${base0F}"; }
        { index = 18; color = "0x${base01}"; }
        { index = 19; color = "0x${base02}"; }
        { index = 20; color = "0x${base04}"; }
        { index = 21; color = "0x${base06}"; }
      ];
    };

    # https://github.com/pinpox/base16-xresources/blob/master/templates/default-256.mustache
    xresources.extraConfig = with cfg.colors; mkIf cfg.xresources ''
      #define base00 #${base00}
      #define base01 #${base01}
      #define base02 #${base02}
      #define base03 #${base03}
      #define base04 #${base04}
      #define base05 #${base05}
      #define base06 #${base06}
      #define base07 #${base07}
      #define base08 #${base08}
      #define base09 #${base09}
      #define base0A #${base0A}
      #define base0B #${base0B}
      #define base0C #${base0C}
      #define base0D #${base0D}
      #define base0E #${base0E}
      #define base0F #${base0F}

      *foreground:   base05
      #ifdef background_opacity
      *background:   [background_opacity]base00
      #else
      *background:   base00
      #endif
      *cursorColor:  base05

      *color0:       base00
      *color1:       base08
      *color2:       base0B
      *color3:       base0A
      *color4:       base0D
      *color5:       base0E
      *color6:       base0C
      *color7:       base05

      *color8:       base03
      *color9:       base08
      *color10:      base0B
      *color11:      base0A
      *color12:      base0D
      *color13:      base0E
      *color14:      base0C
      *color15:      base07

      *color16:      base09
      *color17:      base0F
      *color18:      base01
      *color19:      base02
      *color20:      base04
      *color21:      base06
    '';

    # TODO convert to actual i3 home-manager config
    # https://github.com/khamer/base16-i3/blob/master/templates/default.mustache
    xsession.windowManager.i3.extraConfig = with cfg.colors; mkIf cfg.i3 ''
      set $base00 #${base00}
      set $base01 #${base01}
      set $base02 #${base02}
      set $base03 #${base03}
      set $base04 #${base04}
      set $base05 #${base05}
      set $base06 #${base06}
      set $base07 #${base07}
      set $base08 #${base08}
      set $base09 #${base09}
      set $base0A #${base0A}
      set $base0B #${base0B}
      set $base0C #${base0C}
      set $base0D #${base0D}
      set $base0E #${base0E}
      set $base0F #${base0F}

      # TODO implement bar in actual home-manager config with i3Bar = true
      #bar {
        #colors {
          #background $base00
          #separator  $base01
          #statusline $base04
          ## State             Border  BG      Text
          #focused_workspace   $base05 $base0D $base00
          #active_workspace    $base05 $base03 $base00
          #inactive_workspace  $base03 $base01 $base05
          #urgent_workspace    $base08 $base08 $base00
          #binding_mode        $base00 $base0A $base00
        #}
      #}

      # Property Name         Border  BG      Text    Indicator Child Border
      client.focused          $base05 $base0D $base00 $base0D $base0C
      client.focused_inactive $base01 $base01 $base05 $base03 $base01
      client.unfocused        $base01 $base00 $base05 $base01 $base01
      client.urgent           $base08 $base08 $base00 $base08 $base08
      client.placeholder      $base00 $base00 $base05 $base00 $base00
      client.background       $base07
    '';

    # https://github.com/khamer/base16-dunst/blob/master/templates/default.mustache
    services.dunst.settings = with cfg.colors; mkIf cfg.dunst {
      global = {
        frame_color = "#${base05}";
        separator_color = "#${base05}";
      };
      urgency_low = {
        background = "#${base01}";
        foreground = "#${base03}";
      };
      urgency_normal = {
        background = "#${base02}";
        foreground = "#${base05}";
      };
      urgency_critical = {
        background = "#${base08}";
        foreground = "#${base06}";
      };
    };

    # https://github.com/fnune/base16-fzf/blob/master/templates/default.mustache
    programs.fzf.defaultOptions = with cfg.colors; mkIf cfg.fzf [
      "--color 'fg:#${base04}'" # Text
      "--color 'bg:#${base00}'" # Background
      "--color 'preview-fg:#${base04}'" # Preview window text
      "--color 'preview-bg:#${base00}'" # Preview window background
      "--color 'hl:#${base0D}'" # Highlighted substrings
      "--color 'fg+:#${base06}'" # Text (current line)
      "--color 'bg+:#${base01}'" # Background (current line)
      "--color 'gutter:#${base00}'" # Gutter on the left (defaults to bg+)
      "--color 'hl+:#${base0D}'" # Highlighted substrings (current line)
      "--color 'info:#${base0A}'" # Info line (match counters)
      "--color 'border:#${base0C}'" # Border around the window (--border and --preview)
      "--color 'prompt:#${base0A}'" # Prompt
      "--color 'pointer:#${base0C}'" # Pointer to the current line
      "--color 'marker:#${base0C}'" # Multi-select marker
      "--color 'spinner:#${base0C}'" # Streaming input indicator
      "--color 'header:#${base0D}'" # Header
    ];

    # https://raw.githubusercontent.com/mattdavis90/base16-tmux/master/templates/default.mustache
    programs.tmux.extraConfig = with cfg.colors; mkIf cfg.tmux ''
      # default statusbar colors
      set-option -g status-style "fg=#${base04},bg=#${base01}"

      # default window title colors
      set-window-option -g window-status-style "fg=#${base04},bg=default"

      # active window title colors
      set-window-option -g window-status-current-style "fg=#${base0A},bg=default"

      # pane border
      set-option -g pane-border-style "fg=#${base01}"
      set-option -g pane-active-border-style "fg=#${base02}"

      # message text
      set-option -g message-style "fg=#${base05},bg=#${base01}"

      # pane number display
      set-option -g display-panes-active-colour "#${base0B}"
      set-option -g display-panes-colour "#${base0A}"

      # clock
      set-window-option -g clock-mode-colour "#${base0B}"

      # copy mode highligh
      set-window-option -g mode-style "fg=#${base04},bg=#${base02}"

      # bell
      set-window-option -g window-status-bell-style "fg=#${base01},bg=#${base08}"
    '';

    # https://raw.githubusercontent.com/fnune/base16-vim/master/templates/default.mustache
    # use mkBefore to allow overriding colorscheme in custom config
    programs.neovim.extraConfig = mkIf cfg.neovim (mkBefore ''
      let base16colorspace=256
      colorscheme base16
    '');
    xdg.configFile.neovim-base16theme = with cfg.colors; mkIf cfg.neovim {
      target = "nvim/colors/base16.vim";
      text = ''
        " GUI color definitions
        let s:gui00        = "${base00}"
        let g:base16_gui00 = "${base00}"
        let s:gui01        = "${base01}"
        let g:base16_gui01 = "${base01}"
        let s:gui02        = "${base02}"
        let g:base16_gui02 = "${base02}"
        let s:gui03        = "${base03}"
        let g:base16_gui03 = "${base03}"
        let s:gui04        = "${base04}"
        let g:base16_gui04 = "${base04}"
        let s:gui05        = "${base05}"
        let g:base16_gui05 = "${base05}"
        let s:gui06        = "${base06}"
        let g:base16_gui06 = "${base06}"
        let s:gui07        = "${base07}"
        let g:base16_gui07 = "${base07}"
        let s:gui08        = "${base08}"
        let g:base16_gui08 = "${base08}"
        let s:gui09        = "${base09}"
        let g:base16_gui09 = "${base09}"
        let s:gui0A        = "${base0A}"
        let g:base16_gui0A = "${base0A}"
        let s:gui0B        = "${base0B}"
        let g:base16_gui0B = "${base0B}"
        let s:gui0C        = "${base0C}"
        let g:base16_gui0C = "${base0C}"
        let s:gui0D        = "${base0D}"
        let g:base16_gui0D = "${base0D}"
        let s:gui0E        = "${base0E}"
        let g:base16_gui0E = "${base0E}"
        let s:gui0F        = "${base0F}"
        let g:base16_gui0F = "${base0F}"

        " Terminal color definitions
        let s:cterm00        = "00"
        let g:base16_cterm00 = "00"
        let s:cterm03        = "08"
        let g:base16_cterm03 = "08"
        let s:cterm05        = "07"
        let g:base16_cterm05 = "07"
        let s:cterm07        = "15"
        let g:base16_cterm07 = "15"
        let s:cterm08        = "01"
        let g:base16_cterm08 = "01"
        let s:cterm0A        = "03"
        let g:base16_cterm0A = "03"
        let s:cterm0B        = "02"
        let g:base16_cterm0B = "02"
        let s:cterm0C        = "06"
        let g:base16_cterm0C = "06"
        let s:cterm0D        = "04"
        let g:base16_cterm0D = "04"
        let s:cterm0E        = "05"
        let g:base16_cterm0E = "05"
        if exists("base16colorspace") && base16colorspace == "256"
          let s:cterm01        = "18"
          let g:base16_cterm01 = "18"
          let s:cterm02        = "19"
          let g:base16_cterm02 = "19"
          let s:cterm04        = "20"
          let g:base16_cterm04 = "20"
          let s:cterm06        = "21"
          let g:base16_cterm06 = "21"
          let s:cterm09        = "16"
          let g:base16_cterm09 = "16"
          let s:cterm0F        = "17"
          let g:base16_cterm0F = "17"
        else
          let s:cterm01        = "10"
          let g:base16_cterm01 = "10"
          let s:cterm02        = "11"
          let g:base16_cterm02 = "11"
          let s:cterm04        = "12"
          let g:base16_cterm04 = "12"
          let s:cterm06        = "13"
          let g:base16_cterm06 = "13"
          let s:cterm09        = "09"
          let g:base16_cterm09 = "09"
          let s:cterm0F        = "14"
          let g:base16_cterm0F = "14"
        endif

        " Neovim terminal colours
        if has("nvim")
          let g:terminal_color_0 =  "#${base00}"
          let g:terminal_color_1 =  "#${base08}"
          let g:terminal_color_2 =  "#${base0B}"
          let g:terminal_color_3 =  "#${base0A}"
          let g:terminal_color_4 =  "#${base0D}"
          let g:terminal_color_5 =  "#${base0E}"
          let g:terminal_color_6 =  "#${base0C}"
          let g:terminal_color_7 =  "#${base05}"
          let g:terminal_color_8 =  "#${base03}"
          let g:terminal_color_9 =  "#${base08}"
          let g:terminal_color_10 = "#${base0B}"
          let g:terminal_color_11 = "#${base0A}"
          let g:terminal_color_12 = "#${base0D}"
          let g:terminal_color_13 = "#${base0E}"
          let g:terminal_color_14 = "#${base0C}"
          let g:terminal_color_15 = "#${base07}"
          let g:terminal_color_background = g:terminal_color_0
          let g:terminal_color_foreground = g:terminal_color_5
          if &background == "light"
            let g:terminal_color_background = g:terminal_color_7
            let g:terminal_color_foreground = g:terminal_color_2
          endif
        elseif has("terminal")
          let g:terminal_ansi_colors = [
                \ "#${base00}",
                \ "#${base08}",
                \ "#${base0B}",
                \ "#${base0A}",
                \ "#${base0D}",
                \ "#${base0E}",
                \ "#${base0C}",
                \ "#${base05}",
                \ "#${base03}",
                \ "#${base08}",
                \ "#${base0B}",
                \ "#${base0A}",
                \ "#${base0D}",
                \ "#${base0E}",
                \ "#${base0C}",
                \ "#${base07}",
                \ ]
        endif

        " Theme setup
        hi clear
        syntax reset
        let g:colors_name = "base16"

        " Highlighting function
        " Optional variables are attributes and guisp
        function! g:Base16hi(group, guifg, guibg, ctermfg, ctermbg, ...)
          let l:attr = get(a:, 1, "")
          let l:guisp = get(a:, 2, "")

          " See :help highlight-guifg
          let l:gui_special_names = ["NONE", "bg", "background", "fg", "foreground"]

          if a:guifg != ""
            if index(l:gui_special_names, a:guifg) >= 0
              exec "hi " . a:group . " guifg=" . a:guifg
            else
              exec "hi " . a:group . " guifg=#" . a:guifg
            endif
          endif
          if a:guibg != ""
            if index(l:gui_special_names, a:guibg) >= 0
              exec "hi " . a:group . " guibg=" . a:guibg
            else
              exec "hi " . a:group . " guibg=#" . a:guibg
            endif
          endif
          if a:ctermfg != ""
            exec "hi " . a:group . " ctermfg=" . a:ctermfg
          endif
          if a:ctermbg != ""
            exec "hi " . a:group . " ctermbg=" . a:ctermbg
          endif
          if l:attr != ""
            exec "hi " . a:group . " gui=" . l:attr . " cterm=" . l:attr
          endif
          if l:guisp != ""
            if index(l:gui_special_names, l:guisp) >= 0
              exec "hi " . a:group . " guisp=" . l:guisp
            else
              exec "hi " . a:group . " guisp=#" . l:guisp
            endif
          endif
        endfunction


        fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
          call g:Base16hi(a:group, a:guifg, a:guibg, a:ctermfg, a:ctermbg, a:attr, a:guisp)
        endfun

        " Vim editor colors
        call <sid>hi("Normal",        s:gui05, s:gui00, s:cterm05, s:cterm00, "", "")
        call <sid>hi("Bold",          "", "", "", "", "bold", "")
        call <sid>hi("Debug",         s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("Directory",     s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("Error",         s:gui00, s:gui08, s:cterm00, s:cterm08, "", "")
        call <sid>hi("ErrorMsg",      s:gui08, s:gui00, s:cterm08, s:cterm00, "", "")
        call <sid>hi("Exception",     s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("FoldColumn",    s:gui0C, s:gui01, s:cterm0C, s:cterm01, "", "")
        call <sid>hi("Folded",        s:gui03, s:gui01, s:cterm03, s:cterm01, "", "")
        call <sid>hi("IncSearch",     s:gui01, s:gui09, s:cterm01, s:cterm09, "none", "")
        call <sid>hi("Italic",        "", "", "", "", "none", "")
        call <sid>hi("Macro",         s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("MatchParen",    "", s:gui03, "", s:cterm03,  "", "")
        call <sid>hi("ModeMsg",       s:gui0B, "", s:cterm0B, "", "", "")
        call <sid>hi("MoreMsg",       s:gui0B, "", s:cterm0B, "", "", "")
        call <sid>hi("Question",      s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("Search",        s:gui01, s:gui0A, s:cterm01, s:cterm0A,  "", "")
        call <sid>hi("Substitute",    s:gui01, s:gui0A, s:cterm01, s:cterm0A, "none", "")
        call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("TooLong",       s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("Underlined",    s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("Visual",        "", s:gui02, "", s:cterm02, "", "")
        call <sid>hi("VisualNOS",     s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("WarningMsg",    s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("WildMenu",      s:gui08, s:gui0A, s:cterm08, "", "", "")
        call <sid>hi("Title",         s:gui0D, "", s:cterm0D, "", "none", "")
        call <sid>hi("Conceal",       s:gui0D, s:gui00, s:cterm0D, s:cterm00, "", "")
        call <sid>hi("Cursor",        s:gui00, s:gui05, s:cterm00, s:cterm05, "", "")
        call <sid>hi("NonText",       s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("LineNr",        s:gui03, s:gui01, s:cterm03, s:cterm01, "", "")
        call <sid>hi("SignColumn",    s:gui03, s:gui01, s:cterm03, s:cterm01, "", "")
        call <sid>hi("StatusLine",    s:gui04, s:gui02, s:cterm04, s:cterm02, "none", "")
        call <sid>hi("StatusLineNC",  s:gui03, s:gui01, s:cterm03, s:cterm01, "none", "")
        call <sid>hi("VertSplit",     s:gui02, s:gui02, s:cterm02, s:cterm02, "none", "")
        call <sid>hi("ColorColumn",   "", s:gui01, "", s:cterm01, "none", "")
        call <sid>hi("CursorColumn",  "", s:gui01, "", s:cterm01, "none", "")
        call <sid>hi("CursorLine",    "", s:gui01, "", s:cterm01, "none", "")
        call <sid>hi("CursorLineNr",  s:gui04, s:gui01, s:cterm04, s:cterm01, "bold", "")
        call <sid>hi("QuickFixLine",  "", s:gui01, "", s:cterm01, "none", "")
        call <sid>hi("PMenu",         s:gui05, s:gui01, s:cterm05, s:cterm01, "none", "")
        call <sid>hi("PMenuSel",      s:gui01, s:gui05, s:cterm01, s:cterm05, "", "")
        call <sid>hi("TabLine",       s:gui03, s:gui01, s:cterm03, s:cterm01, "none", "")
        call <sid>hi("TabLineFill",   s:gui03, s:gui01, s:cterm03, s:cterm01, "none", "")
        call <sid>hi("TabLineSel",    s:gui0B, s:gui01, s:cterm0B, s:cterm01, "none", "")

        " Standard syntax highlighting
        call <sid>hi("Boolean",      s:gui09, "", s:cterm09, "", "", "")
        call <sid>hi("Character",    s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("Comment",      s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("Conditional",  s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("Constant",     s:gui09, "", s:cterm09, "", "", "")
        call <sid>hi("Define",       s:gui0E, "", s:cterm0E, "", "none", "")
        call <sid>hi("Delimiter",    s:gui0F, "", s:cterm0F, "", "", "")
        call <sid>hi("Float",        s:gui09, "", s:cterm09, "", "", "")
        call <sid>hi("Function",     s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("Identifier",   s:gui08, "", s:cterm08, "", "none", "")
        call <sid>hi("Include",      s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("Keyword",      s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("Label",        s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("Number",       s:gui09, "", s:cterm09, "", "", "")
        call <sid>hi("Operator",     s:gui05, "", s:cterm05, "", "none", "")
        call <sid>hi("PreProc",      s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("Repeat",       s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("Special",      s:gui0C, "", s:cterm0C, "", "", "")
        call <sid>hi("SpecialChar",  s:gui0F, "", s:cterm0F, "", "", "")
        call <sid>hi("Statement",    s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("StorageClass", s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("String",       s:gui0B, "", s:cterm0B, "", "", "")
        call <sid>hi("Structure",    s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("Tag",          s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("Todo",         s:gui0A, s:gui01, s:cterm0A, s:cterm01, "", "")
        call <sid>hi("Type",         s:gui0A, "", s:cterm0A, "", "none", "")
        call <sid>hi("Typedef",      s:gui0A, "", s:cterm0A, "", "", "")

        " C highlighting
        call <sid>hi("cOperator",   s:gui0C, "", s:cterm0C, "", "", "")
        call <sid>hi("cPreCondit",  s:gui0E, "", s:cterm0E, "", "", "")

        " C# highlighting
        call <sid>hi("csClass",                 s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("csAttribute",             s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("csModifier",              s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("csType",                  s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("csUnspecifiedStatement",  s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("csContextualStatement",   s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("csNewDecleration",        s:gui08, "", s:cterm08, "", "", "")

        " CSS highlighting
        call <sid>hi("cssBraces",      s:gui05, "", s:cterm05, "", "", "")
        call <sid>hi("cssClassName",   s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("cssColor",       s:gui0C, "", s:cterm0C, "", "", "")

        " Diff highlighting
        call <sid>hi("DiffAdd",      s:gui0B, s:gui01,  s:cterm0B, s:cterm01, "", "")
        call <sid>hi("DiffChange",   s:gui03, s:gui01,  s:cterm03, s:cterm01, "", "")
        call <sid>hi("DiffDelete",   s:gui08, s:gui01,  s:cterm08, s:cterm01, "", "")
        call <sid>hi("DiffText",     s:gui0D, s:gui01,  s:cterm0D, s:cterm01, "", "")
        call <sid>hi("DiffAdded",    s:gui0B, s:gui00,  s:cterm0B, s:cterm00, "", "")
        call <sid>hi("DiffFile",     s:gui08, s:gui00,  s:cterm08, s:cterm00, "", "")
        call <sid>hi("DiffNewFile",  s:gui0B, s:gui00,  s:cterm0B, s:cterm00, "", "")
        call <sid>hi("DiffLine",     s:gui0D, s:gui00,  s:cterm0D, s:cterm00, "", "")
        call <sid>hi("DiffRemoved",  s:gui08, s:gui00,  s:cterm08, s:cterm00, "", "")

        " Git highlighting
        call <sid>hi("gitcommitOverflow",       s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("gitcommitSummary",        s:gui0B, "", s:cterm0B, "", "", "")
        call <sid>hi("gitcommitComment",        s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("gitcommitUntracked",      s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("gitcommitDiscarded",      s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("gitcommitSelected",       s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("gitcommitHeader",         s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("gitcommitSelectedType",   s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("gitcommitUnmergedType",   s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("gitcommitDiscardedType",  s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("gitcommitBranch",         s:gui09, "", s:cterm09, "", "bold", "")
        call <sid>hi("gitcommitUntrackedFile",  s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("gitcommitUnmergedFile",   s:gui08, "", s:cterm08, "", "bold", "")
        call <sid>hi("gitcommitDiscardedFile",  s:gui08, "", s:cterm08, "", "bold", "")
        call <sid>hi("gitcommitSelectedFile",   s:gui0B, "", s:cterm0B, "", "bold", "")

        " GitGutter highlighting
        call <sid>hi("GitGutterAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "", "")
        call <sid>hi("GitGutterChange",  s:gui0D, s:gui01, s:cterm0D, s:cterm01, "", "")
        call <sid>hi("GitGutterDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "", "")
        call <sid>hi("GitGutterChangeDelete",  s:gui0E, s:gui01, s:cterm0E, s:cterm01, "", "")

        " HTML highlighting
        call <sid>hi("htmlBold",    s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("htmlItalic",  s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("htmlEndTag",  s:gui05, "", s:cterm05, "", "", "")
        call <sid>hi("htmlTag",     s:gui05, "", s:cterm05, "", "", "")

        " JavaScript highlighting
        call <sid>hi("javaScript",        s:gui05, "", s:cterm05, "", "", "")
        call <sid>hi("javaScriptBraces",  s:gui05, "", s:cterm05, "", "", "")
        call <sid>hi("javaScriptNumber",  s:gui09, "", s:cterm09, "", "", "")
        " pangloss/vim-javascript highlighting
        call <sid>hi("jsOperator",          s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("jsStatement",         s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("jsReturn",            s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("jsThis",              s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("jsClassDefinition",   s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("jsFunction",          s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("jsFuncName",          s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("jsFuncCall",          s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("jsClassFuncName",     s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("jsClassMethodType",   s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("jsRegexpString",      s:gui0C, "", s:cterm0C, "", "", "")
        call <sid>hi("jsGlobalObjects",     s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("jsGlobalNodeObjects", s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("jsExceptions",        s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("jsBuiltins",          s:gui0A, "", s:cterm0A, "", "", "")

        " Mail highlighting
        call <sid>hi("mailQuoted1",  s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("mailQuoted2",  s:gui0B, "", s:cterm0B, "", "", "")
        call <sid>hi("mailQuoted3",  s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("mailQuoted4",  s:gui0C, "", s:cterm0C, "", "", "")
        call <sid>hi("mailQuoted5",  s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("mailQuoted6",  s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("mailURL",      s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("mailEmail",    s:gui0D, "", s:cterm0D, "", "", "")

        " Markdown highlighting
        call <sid>hi("markdownCode",              s:gui0B, "", s:cterm0B, "", "", "")
        call <sid>hi("markdownError",             s:gui05, s:gui00, s:cterm05, s:cterm00, "", "")
        call <sid>hi("markdownCodeBlock",         s:gui0B, "", s:cterm0B, "", "", "")
        call <sid>hi("markdownHeadingDelimiter",  s:gui0D, "", s:cterm0D, "", "", "")

        " NERDTree highlighting
        call <sid>hi("NERDTreeDirSlash",  s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("NERDTreeExecFile",  s:gui05, "", s:cterm05, "", "", "")

        " PHP highlighting
        call <sid>hi("phpMemberSelector",  s:gui05, "", s:cterm05, "", "", "")
        call <sid>hi("phpComparison",      s:gui05, "", s:cterm05, "", "", "")
        call <sid>hi("phpParent",          s:gui05, "", s:cterm05, "", "", "")
        call <sid>hi("phpMethodsVar",      s:gui0C, "", s:cterm0C, "", "", "")

        " Python highlighting
        call <sid>hi("pythonOperator",  s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("pythonRepeat",    s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("pythonInclude",   s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("pythonStatement", s:gui0E, "", s:cterm0E, "", "", "")

        " Ruby highlighting
        call <sid>hi("rubyAttribute",               s:gui0D, "", s:cterm0D, "", "", "")
        call <sid>hi("rubyConstant",                s:gui0A, "", s:cterm0A, "", "", "")
        call <sid>hi("rubyInterpolationDelimiter",  s:gui0F, "", s:cterm0F, "", "", "")
        call <sid>hi("rubyRegexp",                  s:gui0C, "", s:cterm0C, "", "", "")
        call <sid>hi("rubySymbol",                  s:gui0B, "", s:cterm0B, "", "", "")
        call <sid>hi("rubyStringDelimiter",         s:gui0B, "", s:cterm0B, "", "", "")

        " SASS highlighting
        call <sid>hi("sassidChar",     s:gui08, "", s:cterm08, "", "", "")
        call <sid>hi("sassClassChar",  s:gui09, "", s:cterm09, "", "", "")
        call <sid>hi("sassInclude",    s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("sassMixing",     s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("sassMixinName",  s:gui0D, "", s:cterm0D, "", "", "")

        " Signify highlighting
        call <sid>hi("SignifySignAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "", "")
        call <sid>hi("SignifySignChange",  s:gui0D, s:gui01, s:cterm0D, s:cterm01, "", "")
        call <sid>hi("SignifySignDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "", "")

        " Spelling highlighting
        call <sid>hi("SpellBad",     "", "", "", "", "undercurl", s:gui08)
        call <sid>hi("SpellLocal",   "", "", "", "", "undercurl", s:gui0C)
        call <sid>hi("SpellCap",     "", "", "", "", "undercurl", s:gui0D)
        call <sid>hi("SpellRare",    "", "", "", "", "undercurl", s:gui0E)

        " Startify highlighting
        call <sid>hi("StartifyBracket",  s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("StartifyFile",     s:gui07, "", s:cterm07, "", "", "")
        call <sid>hi("StartifyFooter",   s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("StartifyHeader",   s:gui0B, "", s:cterm0B, "", "", "")
        call <sid>hi("StartifyNumber",   s:gui09, "", s:cterm09, "", "", "")
        call <sid>hi("StartifyPath",     s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("StartifySection",  s:gui0E, "", s:cterm0E, "", "", "")
        call <sid>hi("StartifySelect",   s:gui0C, "", s:cterm0C, "", "", "")
        call <sid>hi("StartifySlash",    s:gui03, "", s:cterm03, "", "", "")
        call <sid>hi("StartifySpecial",  s:gui03, "", s:cterm03, "", "", "")

        " Neovim Treesitter highlighting
        if has("nvim")
          call <sid>hi("TSFunction",        s:gui0D, "", s:cterm0D, "", "", "")
          call <sid>hi("TSKeywordFunction", s:gui0E, "", s:cterm0E, "", "", "")
          call <sid>hi("TSMethod",          s:gui0D, "", s:cterm0D, "", "", "")
          call <sid>hi("TSProperty",        s:gui0A, "", s:cterm0A, "", "", "")
          call <sid>hi("TSPunctBracket",    s:gui0C, "", s:cterm0C, "", "", "")
          call <sid>hi("TSType",            s:gui08, "", s:cterm08, "", "none", "")
        endif

        " LSP highlighting
        if has("nvim")
          call <sid>hi("LspDiagnosticsDefaultError",       s:gui08, "", s:cterm08, "", "", "")
          call <sid>hi("LspDiagnosticsDefaultWarning",     s:gui09, "", s:cterm09, "", "", "")
          call <sid>hi("LspDiagnosticsDefaultInformation", s:gui05, "", s:cterm05, "", "", "")
          call <sid>hi("LspDiagnosticsDefaultHint",        s:gui03, "", s:cterm03, "", "", "")
        endif

        " Java highlighting
        call <sid>hi("javaOperator",     s:gui0D, "", s:cterm0D, "", "", "")

        " Remove functions
        delf <sid>hi

        " Remove color variables
        unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
        unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
      '';
    };

    # https://github.com/dawikur/base16-vim-airline-themes/blob/master/templates/default.mustache
    # TODO fix this and write to plugin path
    xdg.configFile.neovim-airline-base16theme = with cfg.colors; mkIf cfg.neovim_airline {
      target = "nvim/autoload/airline/themes/base16.vim";
      text = ''
        let g:airline#themes#base16#palette = {}

        " GUI color definitions
        let s:gui00 = '#${base00}'
        let s:gui01 = '#${base01}'
        let s:gui02 = '#${base02}'
        let s:gui03 = '#${base03}'
        let s:gui04 = '#${base04}'
        let s:gui05 = '#${base05}'
        let s:gui06 = '#${base06}'
        let s:gui07 = '#${base07}'
        let s:gui08 = '#${base08}'
        let s:gui09 = '#${base09}'
        let s:gui0A = '#${base0A}'
        let s:gui0B = '#${base0B}'
        let s:gui0C = '#${base0C}'
        let s:gui0D = '#${base0D}'
        let s:gui0E = '#${base0E}'
        let s:gui0F = '#${base0F}'

        " Terminal color definitions
        let s:cterm00        = "00"
        let s:cterm03        = "08"
        let s:cterm05        = "07"
        let s:cterm07        = "15"
        let s:cterm08        = "01"
        let s:cterm0A        = "03"
        let s:cterm0B        = "02"
        let s:cterm0C        = "06"
        let s:cterm0D        = "04"
        let s:cterm0E        = "05"
        if exists("base16colorspace") && base16colorspace == "256"
          let s:cterm01        = "18"
          let s:cterm02        = "19"
          let s:cterm04        = "20"
          let s:cterm06        = "21"
          let s:cterm09        = "16"
          let s:cterm0F        = "17"
        else
          let s:cterm01        = "10"
          let s:cterm02        = "11"
          let s:cterm04        = "12"
          let s:cterm06        = "13"
          let s:cterm09        = "09"
          let s:cterm0F        = "14"
        endif

        let g:airline#themes#base16#palette.normal = airline#themes#generate_color_map(
          \ [ s:gui01, s:gui04, s:cterm01, s:cterm04 ],
          \ [ s:gui04, s:gui02, s:cterm04, s:cterm02 ],
          \ [ s:gui04, s:gui01, s:cterm04, s:cterm01 ])
        let g:airline#themes#base16#palette.normal_modified = {
          \ 'airline_c' : [ s:gui07, s:gui01, s:cterm07, s:cterm01 ]}

        let g:airline#themes#base16#palette.insert = airline#themes#generate_color_map(
          \ [ s:gui01, s:gui0B, s:cterm01, s:cterm0B ],
          \ [ s:gui04, s:gui02, s:cterm04, s:cterm02 ],
          \ [ s:gui04, s:gui01, s:cterm04, s:cterm01 ])
        let g:airline#themes#base16#palette.insert_modified = {
          \ 'airline_c' : [ s:gui07, s:gui01, s:cterm07, s:cterm01 ]}

        let g:airline#themes#base16#palette.replace = airline#themes#generate_color_map(
          \ [ s:gui01, s:gui0E, s:cterm01, s:cterm0E ],
          \ [ s:gui04, s:gui02, s:cterm04, s:cterm02 ],
          \ [ s:gui04, s:gui01, s:cterm04, s:cterm01 ])
        let g:airline#themes#base16#palette.replace_modified = {
          \ 'airline_c' : [ s:gui07, s:gui01, s:cterm07, s:cterm01 ]}

        let g:airline#themes#base16#palette.visual = airline#themes#generate_color_map(
          \ [ s:gui01, s:gui09, s:cterm01, s:cterm09 ],
          \ [ s:gui04, s:gui02, s:cterm04, s:cterm02 ],
          \ [ s:gui04, s:gui01, s:cterm04, s:cterm01 ])
        let g:airline#themes#base16#palette.visual_modified = {
          \ 'airline_c' : [ s:gui07, s:gui01, s:cterm07, s:cterm01 ]}

        let g:airline#themes#base16#palette.inactive = airline#themes#generate_color_map(
          \ [ s:gui01, s:gui01, s:cterm01, s:cterm01 ],
          \ [ s:gui04, s:gui01, s:cterm04, s:cterm01 ],
          \ [ s:gui05, s:gui01, s:cterm05, s:cterm01 ])
      '';
    };
  }; # end config
}
