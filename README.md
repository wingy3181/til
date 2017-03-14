# TIL

> Today I Learned

A collection of concise write-ups on small things I learn day to day across a
variety of languages and technologies.

_21 TILs and counting..._

---

## Categories

* [tmux](#tmux)

---

### tmux

- [Adjusting Window Pane Size](tmux/adjusting-window-pane-size.md)
- [All In One Cheatsheet](tmux/all-in-one-cheatsheet.md)
- [Create A Named tmux Session](tmux/create-a-named-tmux-session.md)
- [Customizing tmux](tmux/customizing-tmux.md)
- [Cycle Through Layouts](tmux/cycle-through-layouts.md)
- [Display Pane Number And Focus Pane](tmux/display-pane-number-and-focus-pane.)
- [Enabling Vi Mode](tmux/enabling-vi-mode.md)
- [Jumping Between Sessions](tmux/jumping-between-sessions.md)
- [Kill Other Connections To A Session](tmux/kill-other-connections-to-a-session.md)
- [Kill The Current Session](tmux/kill-the-current-session.md)
- [List All Key Bindings](tmux/list-all-key-bindings.md)
- [List Sessions](tmux/list-sessions.md)
- [Open New Window With A Specific Directory](tmux/open-new-window-with-a-specific-directory.md)
- [Organizing Windows](tmux/organizing-windows.md)
- [Paging Up And Down](tmux/paging-up-and-down.md)
- [Pane Killer](tmux/pane-killer.md)
- [Reclaiming The Entire Window](tmux/reclaiming-the-entire-window.md)
- [Rename The Current Session](tmux/rename-the-current-session.md)
- [Rename The Current Window](tmux/rename-the-current-window.md)
- [Swap Split Panes](tmux/swap-split-panes.md)

> References
> * http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
> * https://github.com/ckloppers/tmux.conf/blob/master/tmux.conf_for_windows_21April2015
> * https://gist.github.com/MohamedAlaa/2961058

---

### web development

- [Website Performance Optimization and Critical Rendering Path](web-development/website-performance-optimization-and-critical-rendering-path.md)

### webpack

- [How to separate development and production config](wep)
  - 2 ways, either you process env or separate config and can extend one from the other
- [Global vs local install](webpack/)
  - Install locally && Use npm scripts
  - https://www.joezimjs.com/javascript/no-more-global-npm-packages/
- [How to configure loaders]
- [CSS splitting to avoid FOUC and use style and css loader]
- [Code splitting - dynamic vs static ]

## Usage

- The `.vimrc` file for this project contains a function `CountTILs` that can
be invoked with `<leader>c`. This will do a substitution count of the
current number of TILs and display the result in the command tray.
- The `today-i-learned.sh` script for this project will prompt you for what you learnt
and the topic. Using this information, it will automatically generate the folder structure,
Markdown content for `README.md` and Markdown file for you to start entering your notes.

## About

I shamelessly stole this repository and idea from
[jbranchaud/til](https://github.com/jbranchaud/til) and
[thoughtbot/til](https://github.com/thoughtbot/til) respectively.

## Other TIL Collections

* [jwworth/til](https://github.com/jwworth/til)
* [jbranchaud/til](https://github.com/jbranchaud/til)
* [thoughtbot/til](https://github.com/thoughtbot/til)

## License

&copy; 2016-2017 Cheong Yip

This repository is licensed under the MIT license. See `LICENSE` for
details.
