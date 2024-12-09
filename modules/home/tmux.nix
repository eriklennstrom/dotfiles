{pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-Space";
    clock24 = true;
    shell = "${pkgs.zsh}/bin/zsh";
    # catppuccin = {
    #   enable = true;

    # };
    extraConfig = ''
        set -g @catppuccin_flavour 'macchiato' # or latte, frappe, macchiato, mocha
        set -g @catppuccin_window_right_separator " "
        # set -g @catppuccin_window_right_separator ""
        set -g @catppuccin_window_middle_separator " █"
        # set -g @catppuccin_window_right_separator "█"
        set -g @catppuccin_window_left_separator ""
        # set -g @catppuccin_window_left_separator ""
        # set -g @catppuccin_window_left_separator ""
        set -g @catppuccin_window_number_position "left"
        set -g @catppuccin_window_middle_separator " "
        set -g @catppuccin_window_default_text "#W"
        set -g @catppuccin_window_default_fill "number"
        set -g @catppuccin_window_current_fill "all"
        set -g @catppuccin_window_current_text "#W"
        set -g @catppuccin_status_modules_right "user host session"
        set -g @catppuccin_status_left_separator  " "
        # set -g @catppuccin_status_left_separator "█"
        set -g @catppuccin_status_right_separator ""
        # set -g @catppuccin_status_right_separator "█"
        set -g @catppuccin_status_right_separator_inverse "no"
        set -g @catppuccin_status_fill "all"
        set -g @catppuccin_status_connect_separator "no"
        set -g @catppuccin_directory_text "#{pane_current_path}"
#--------------------------------------------------------------------------
# Key Bindings
#--------------------------------------------------------------------------


# Set the prefix to Ctrl+Space
set -g prefix C-s

# Send prefix to a nested tmux session by doubling the prefix
bind C-Space send-prefix

# 'PREFIX r' to reload of the config file
unbind r
bind r source-file ~/.tmux.conf\; display-message '~/.tmux.conf reloaded'

# Allow holding Ctrl when using using prefix+p/n for switching windows
bind C-p previous-window
bind C-n next-window

# Move around panes like in vim
bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# Smart pane switching with awareness of vim splits
is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?)(diff)?$"'
bind -n C-h if-shell "$is_vim" "send-keys C-h" "select-pane -L"
bind -n C-j if-shell "$is_vim" "send-keys C-j" "select-pane -D"
bind -n C-k if-shell "$is_vim" "send-keys C-k" "select-pane -U"
bind -n C-l if-shell "$is_vim" "send-keys C-l" "select-pane -R"

# Switch between previous and next windows with repeatable
bind -r n next-window
bind -r p previous-window

# Move the current window to the next window or previous window position
bind -r N run-shell "tmux swap-window -t $(expr $(tmux list-windows | grep \"(active)\" | cut -d \":\" -f 1) + 1)"
bind -r P run-shell "tmux swap-window -t $(expr $(tmux list-windows | grep \"(active)\" | cut -d \":\" -f 1) - 1)"

# Switch between two most recently used windows
bind Space last-window

# Switch between two most recently used sessions
bind ^ switch-client -l

# use PREFIX+| (or PREFIX+\) to split window horizontally and PREFIX+- or
# (PREFIX+_) to split vertically also use the current pane path to define the
# new pane path
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

# Change the path for newly created windows
bind c new-window -c "#{pane_current_path}"


    '';
    plugins = [
      pkgs.tmuxPlugins.better-mouse-mode
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.catppuccin
    ];

  };
}
