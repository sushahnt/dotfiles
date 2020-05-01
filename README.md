# .dotfiles

## Terminal Capabilities

In order to properly support italic fonts in and out of tmux, a couple of terminal capabilities need to be described. Run the following from the root of the project:

```bash
tic -x resources/xterm-256color-italic.terminfo
tic -x resources/tmux.terminfo
```