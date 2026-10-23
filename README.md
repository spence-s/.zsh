# .zsh

My dotfiles and zsh configurations

## Install

```sh
# zshrc
rm ~/.zshrc
ln -s ~/.zsh/.zshrc ~/.zshrc

# p10k
rm ~/.p10k.zsh
ln -s ~/.zsh/.p10k.zsh ~/.p10k.zsh

# zed — run once per computer; preserve the existing directory outside Git
mv ~/.config/zed ~/.config/zed.backup-$(date +%Y%m%d%H%M%S) &&
ln -s ~/.zsh/zed ~/.config/zed
```

## Iterm2

- Better dracula colors than the iterm2 colors repo - which does not include any of the bright color ansi variants.
- Profile setup with both colors and text editing shortcuts to my preferences

## p10k

- Setup up for my multiline prompt preferences
- Colors customized for dracula themes

## Zed

- Sync zed settings across my devices
- ignore prompts and device specific things
- symlinking zed settings may require manual window reloads to get settings to apply
