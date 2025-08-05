#!/bin/bash

# Save Claude Configuration to Local Script
# Copy repository .claude configuration files to local ~/.claude directory

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
SOURCE_DIR="$(pwd)/.claude"
TARGET_DIR="$HOME/.claude"

print_msg $BLUE "Starting Claude configuration save to local..."
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

# Copy commands directory
if [ -d "$SOURCE_DIR/commands" ]; then
    print_msg $BLUE "Copying commands directory..."
    mkdir -p "$TARGET_DIR/commands"
    rsync -av --exclude='.local.*' "$SOURCE_DIR/commands/" "$TARGET_DIR/commands/"
    print_msg $GREEN "✓ Commands directory copied"
else
    print_msg $YELLOW "⚠ Commands directory does not exist, skipping"
fi

# Copy templates directory
if [ -d "$SOURCE_DIR/templates" ]; then
    print_msg $BLUE "Copying templates directory..."
    mkdir -p "$TARGET_DIR/templates"
    rsync -av --exclude='.local.*' "$SOURCE_DIR/templates/" "$TARGET_DIR/templates/"
    print_msg $GREEN "✓ Templates directory copied"
else
    print_msg $YELLOW "⚠ Templates directory does not exist, skipping"
fi

# Copy agents directory
if [ -d "$SOURCE_DIR/agents" ]; then
    print_msg $BLUE "Copying agents directory..."
    mkdir -p "$TARGET_DIR/agents"
    rsync -av --exclude='.local.*' "$SOURCE_DIR/agents/" "$TARGET_DIR/agents/"
    print_msg $GREEN "✓ Agents directory copied"
else
    print_msg $YELLOW "⚠ Agents directory does not exist, skipping"
fi

# Copy settings.json file (only if it's not a .local.* file)
if [ -f "$SOURCE_DIR/settings.json" ]; then
    print_msg $BLUE "Copying settings.json file..."
    cp "$SOURCE_DIR/settings.json" "$TARGET_DIR/settings.json"
    print_msg $GREEN "✓ Settings.json file copied"
else
    print_msg $YELLOW "⚠ Settings.json file does not exist, skipping"
fi

print_msg $GREEN "🎉 Claude configuration save to local completed!"

print_msg $YELLOW "\nNote: Existing files were overwritten, but no files were deleted from ~/.claude"
print_msg $YELLOW "Files matching pattern '.local.*' were excluded from copying"
