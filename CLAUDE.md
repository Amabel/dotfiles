# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages shell configuration, Git settings, and Claude Code configuration for development environments. The repository focuses on synchronizing local configurations with version control.

## Key Commands

### Claude Configuration Management
- `./sync-claude-config.sh` - Sync local ~/.claude configuration to repository .claude directory
- `./save-claude-to-local.sh` - Copy repository .claude configuration to local ~/.claude directory

Both scripts:
- Must be run from the repository root directory
- Use rsync for efficient file synchronization
- Provide colored output for status feedback
- Handle missing directories gracefully

### Git Operations
Standard git operations are used for version control. The repository uses `master` as the main branch.

## Architecture and Structure

### Configuration Files
- `.zshrc` - Zsh shell configuration with oh-my-zsh setup, includes nvm and git plugins
- `.tmux.conf` - Tmux terminal multiplexer configuration (extensive configuration file)
- `.gitignore_global` - Global Git ignore patterns for common files (DS_Store, node_modules, etc.)

### Scripts
- `save-claude-to-local.sh` - Copies .claude configs from repository to ~/.claude (excludes .local.* files)
- `sync-claude-config.sh` - Syncs ~/.claude configs to repository .claude directory (with --delete)

### Shell Environment
- Uses oh-my-zsh with "ys" theme
- NVM for Node.js version management
- Git and GitHub CLI plugins enabled
- Custom ZSH directory at ~/.zsh

### Claude Configuration Structure
The .claude directory contains:
- `commands/` - Custom Claude Code commands
- `templates/` - Template files
- `agents/` - Custom agent configurations
- `settings.json` - Claude Code settings

## Development Workflow

1. Make changes to local ~/.claude configuration
2. Run `./sync-claude-config.sh` to sync to repository
3. Review changes with `git status` and `git diff`
4. Commit and push changes
5. Use `./save-claude-to-local.sh` on other machines to apply configurations

## Installation

The repository can be installed using:
```sh
curl --fail --silent --show-error --location https://codeload.github.com/Amabel/dotfiles/tar.gz/master | tar -x -C ~ --strip-components=1
```

This extracts dotfiles directly to the home directory, requiring oh-my-zsh to be installed first.
