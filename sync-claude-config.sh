#!/bin/bash

# Claude Configuration Sync Script
# Sync local ~/.claude configuration files to repository .claude directory

set -e  # Exit on error

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored messages
print_msg() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Check if running in correct directory
if [ ! -f "README.md" ] || [ ! -d ".git" ]; then
    print_msg $RED "Error: Please run this script in the dotfiles-for-dev-container repository root directory"
    exit 1
fi

# Define source and target directories
SOURCE_DIR="$HOME/.claude"
TARGET_DIR="$(pwd)/.claude"

print_msg $BLUE "Starting Claude configuration sync..."
print_msg $YELLOW "Source directory: $SOURCE_DIR"
print_msg $YELLOW "Target directory: $TARGET_DIR"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    print_msg $RED "Error: Source directory $SOURCE_DIR does not exist"
    exit 1
fi

# Create target directory
mkdir -p "$TARGET_DIR"
print_msg $GREEN "✓ Target directory prepared: $TARGET_DIR"

# Sync commands directory
if [ -d "$SOURCE_DIR/commands" ]; then
    print_msg $BLUE "Syncing commands directory..."
    rsync -av --delete "$SOURCE_DIR/commands/" "$TARGET_DIR/commands/"
    print_msg $GREEN "✓ Commands directory synced"
else
    print_msg $YELLOW "⚠ Commands directory does not exist, skipping"
fi

# Sync templates directory
if [ -d "$SOURCE_DIR/templates" ]; then
    print_msg $BLUE "Syncing templates directory..."
    rsync -av --delete "$SOURCE_DIR/templates/" "$TARGET_DIR/templates/"
    print_msg $GREEN "✓ Templates directory synced"
else
    print_msg $YELLOW "⚠ Templates directory does not exist, skipping"
fi

# Sync agents directory
if [ -d "$SOURCE_DIR/agents" ]; then
    print_msg $BLUE "Syncing agents directory..."
    rsync -av --delete "$SOURCE_DIR/agents/" "$TARGET_DIR/agents/"
    print_msg $GREEN "✓ Agents directory synced"
else
    print_msg $YELLOW "⚠ Agents directory does not exist, skipping"
fi

# Sync settings.json file
if [ -f "$SOURCE_DIR/settings.json" ]; then
    print_msg $BLUE "Syncing settings.json file..."
    cp "$SOURCE_DIR/settings.json" "$TARGET_DIR/settings.json"
    print_msg $GREEN "✓ Settings.json file synced"
else
    print_msg $YELLOW "⚠ Settings.json file does not exist, skipping"
fi

print_msg $GREEN "🎉 Claude configuration sync completed!"

# Display synced directory structure
print_msg $BLUE "\nSynced .claude directory structure:"
if command -v tree >/dev/null 2>&1; then
    tree "$TARGET_DIR"
else
    find "$TARGET_DIR" -type f | sort
fi

print_msg $YELLOW "\nNext steps:"
print_msg $YELLOW "1. Review synced file contents"
print_msg $YELLOW "2. Use 'git add .claude' to add to version control"
print_msg $YELLOW "3. Commit and push to GitHub"