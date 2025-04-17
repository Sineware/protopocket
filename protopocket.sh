#!/usr/bin/env bash
set -e

SOURCE_DIR="$(pwd)"
TARGET_DIR="$HOME/.local/var/pmbootstrap/cache_git/pmaports/device/testing"

DEVICE_DIR="device-sineware-protopocket"
LINUX_DIR="linux-sineware-protopocket"

function show_help {
    echo "Usage: $0 COMMAND"
    echo ""
    echo "Commands:"
    echo "  install    Create symlinks from local directories to pmaports dir"
    echo "  pmapull    Remove symlinks, runs 'pmbootstrap pull', then recreate symlinks"
    echo "  remove     Remove symlinks"
    echo "  help       Show this help message"
}

function check_directories {
    if [ ! -d "$SOURCE_DIR/$DEVICE_DIR" ]; then
        echo "Error: Directory $DEVICE_DIR not found in current directory"
        exit 1
    fi

    if [ ! -d "$SOURCE_DIR/$LINUX_DIR" ]; then
        echo "Error: Directory $LINUX_DIR not found in current directory"
        exit 1
    fi

    if [ ! -d "$TARGET_DIR" ]; then
        echo "Error: Target directory $TARGET_DIR not found"
        echo "Make sure pmbootstrap is initialized properly"
        exit 1
    fi
}

function create_symlinks {
    echo "Creating symlinks in $TARGET_DIR..."
    ln -sf "$SOURCE_DIR/$DEVICE_DIR" "$TARGET_DIR/"
    ln -sf "$SOURCE_DIR/$LINUX_DIR" "$TARGET_DIR/"
    echo "Symlinks created successfully!"
}

function remove_symlinks {
    echo "Removing symlinks..."
    if [ -L "$TARGET_DIR/$DEVICE_DIR" ]; then
        rm "$TARGET_DIR/$DEVICE_DIR"
    fi
    if [ -L "$TARGET_DIR/$LINUX_DIR" ]; then
        rm "$TARGET_DIR/$LINUX_DIR"
    fi
    echo "Symlinks removed successfully!"
}

case "$1" in
    install)
        check_directories
        create_symlinks
        ;;
    pmapull)
        check_directories
        remove_symlinks
        echo "Running 'pmbootstrap pull'..."
        pmbootstrap pull
        create_symlinks
        ;;
    remove)
        remove_symlinks
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Error: Unknown command '$1'"
        show_help
        exit 1
        ;;
esac

exit 0