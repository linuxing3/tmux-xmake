#!/usr/bin/env bash

commands=$(echo "install build run project clean config create test" | tr ' ' '\n')
selected=$(printf "$commands" | fzf)

#
#     b, build        Build targets if no given tasks.
#     c, clean        Remove all binary and temporary files.
#     f, config       Configure the project.
#        create       Create a new project.
#     g, global       Configure the global options for xmake.
#     i, install      Package and install the target binary files.
#     p, package      Package target.
#     q, require      Install and update required packages.
#     r, run          Run the project target.
#        service      Start service for remote or distributed compilation and etc.
#        test         Run the project tests.
#     u, uninstall    Uninstall the project binary files.
#        update       Update and uninstall the xmake program.
#
# Plugins:
#        check        Check the project sourcecode and configuration.
#        doxygen      Generate the doxygen document.
#        format       Format the current project.

function read_query() {
	local query_message=$1

	read -p -r "$query_message: " query

	if [[ -z $query ]]; then
		exit
	fi

	return query
}

# Exit if nothing selected
if [[ -z $selected ]]; then
	exit

# configure project
elif [ $selected = "project" ]; then
	query=$(read_query "Project")
	xmake $selected $query

# install package
elif [ $selected = "install" ]; then
	query=$(read_query "Install")
	xmake $selected $query

# change config
elif [ $selected = "config" ]; then
	query=$(read_query "Config")
	xmake $selected $query

# create new project
elif [ $selected = "create" ]; then
	query=$(read_query "Create")
	xmake $selected -y -l c++ -t tbox.console $query

# Just run selected command
else
	xmake $selected
fi

echo
echo "COMPLETE"

tmux copy-mode
tmux send-keys 'k0'

# Prevent window to close
read -n 1 -s
