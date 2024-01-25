#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux bind-key b run-shell "tmux neww $CURRENT_DIR/scripts/run_xmake.sh '#{pane_current_path}'"
