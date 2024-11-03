{ ... }: {
  home.file.aerospace = {
    target = ".aerospace.toml";
    text = ''
      enable-normalization-flatten-containers = false
      enable-normalization-opposite-orientation-for-nested-containers = false

      [gaps]
      inner.horizontal = 15
      inner.vertical   = 15
      outer.left       = 15
      outer.bottom     = 15
      outer.top        = 15
      outer.right      = 15

      [mode.main.binding]
      alt-j = 'focus down'
      alt-k = 'focus up'
      alt-l = 'focus right'
      alt-h = 'focus left'

      alt-shift-j = 'move down'
      alt-shift-k = 'move up'
      alt-shift-l = 'move right'
      alt-shift-h = 'move left'

      alt-f = 'fullscreen'
      alt-d = 'layout h_accordion tiles' # 'layout tabbed' in i3
      alt-shift-space = 'layout floating tiling'

      alt-q = 'workspace 1'
      alt-w = 'workspace 2'
      alt-e = 'workspace 3'
      alt-r = 'workspace 4'
      alt-t = 'workspace 5'

      alt-shift-q = 'move-node-to-workspace 1'
      alt-shift-w = 'move-node-to-workspace 2'
      alt-shift-e = 'move-node-to-workspace 3'
      alt-shift-r = 'move-node-to-workspace 4'
      alt-shift-t = 'move-node-to-workspace 5'

      alt-shift-c = 'reload-config'

      [workspace-to-monitor-force-assignment]
      1 = 'main'
      2 = 'main'
      3 = 'main'
      4 = 'main'
      5 = ['built-in', 'secondary', 'main']

      [[on-window-detected]]
      if.app-name-regex-substring = 'reminder'
      run = 'move-node-to-workspace 1'

      [[on-window-detected]]
      if.app-name-regex-substring = 'mail'
      run = 'move-node-to-workspace 1'

      [[on-window-detected]]
      if.app-name-regex-substring = 'calendar'
      run = 'move-node-to-workspace 1'

      # code
      [[on-window-detected]]
      if.app-name-regex-substring = 'intellij'
      run = 'move-node-to-workspace 2'

      [[on-window-detected]]
      if.app-name-regex-substring = 'alacritty'
      run = 'move-node-to-workspace 2'

      [[on-window-detected]]
      if.app-name-regex-substring = 'arc'
      run = 'move-node-to-workspace 2'

      [[on-window-detected]]
      if.app-name-regex-substring = 'code'
      run = 'move-node-to-workspace 2'

      # chat
      [[on-window-detected]]
      if.app-name-regex-substring = 'signal'
      run = 'move-node-to-workspace 3'

      [[on-window-detected]]
      if.app-name-regex-substring = 'messages'
      run = 'move-node-to-workspace 3'

      # utils
      [[on-window-detected]]
      if.app-name-regex-substring = 'spotify'
      run = 'move-node-to-workspace 4'

      [[on-window-detected]]
      if.app-name-regex-substring = 'bitwarden'
      run = 'move-node-to-workspace 4'

      # business
      [[on-window-detected]]
      if.app-name-regex-substring = 'teams'
      run = 'move-node-to-workspace 5'

      [[on-window-detected]]
      if.app-name-regex-substring = 'slack'
      run = 'move-node-to-workspace 5'
    '';
  };
}
