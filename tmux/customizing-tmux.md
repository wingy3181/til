# Customizing tmux

tmux uses a configuration file `tmux.conf` to store the its configuration.
If you store that file at `~./tmux.conf`, tmux will pick up this configuration
for the current user.

There is also a system-wide location for this configuration file to share
it across multiple users. This is dependent on operating system. Please visit
the tmux documentation (`man tmux` ).

## Binding keys syntax

tmux allows a command to be bound to most keys, with or without a prefix key.  

When specifying keys, most represent themselves (for example `A` to `Z`).  Ctrl
keys may be prefixed with `C-` or `^`, Shift keys with `S-` and Alt (meta) with
`M-`.  In addition, the following special key names are accepted: `Up`, `Down`,
`Left`, `Right`, `BSpace`, `BTab`, `DC` (Delete), `End`, `Enter`, `Escape`, `F1`
to `F12`, `Home`, `IC` (Insert), `NPage/PageDown/PgDn`, `PPage/PageUp/PgUp`,
`Space`, and `Tab`.  Note that to bind the `"` or `'` keys, quotation marks
are necessary, for example:
```
bind-key '"' split-window
bind-key "'" new-window
```

Some examples of binding commands are:
```
# Reload tmux configuration with <prefix>r and display "Reloaded"
bind r source-file ~/.tmux.conf \; display "Reloaded"
# resize panes using Shift-arrow without prefix
bind -n S-Left resize-pane -L
```

Documentation from `man tmux`
```
bind-key [-cnr] [-t mode-table] [-T key-table] key command [arguments]
(alias: bind)
```
Bind key to command.  Keys are bound in a key table.  By default (without `-T`),
the key is bound in the prefix key table.  This table is used for keys pressed
after the prefix key (for example, by default `c` is bound to new-window in the
prefix table, so `C-b c` creates a new window).  The root table is used for
keys pressed without the prefix key: binding `c` to new-window in the root
table (not recommended) means a plain ‘c’ will create a new window.  `-n` is
an alias for `-T root`.  Keys may also be bound in custom key tables and the
switch-client -T command used to switch to them from a key binding.  

The `-r` flag indicates this key may repeat, see the repeat-time option. This
is useful for example when resizing panes and the prefix key does not need to be
pressed subsequent times if the bind key is pressed again within the time
interval (~500ms)

If `-t` is present, key is bound in mode-table: the binding for command mode
with `-c` or for normal mode without.

## Unbinding keys syntax
```
unbind-key [-acn] [-t mode-table] [-T key-table] key
(alias: unbind)
```
Unbind the command bound to key.  -c, -n, -T and -t are the same as for bind-key.  
If -a is present, all key bindings are removed.
