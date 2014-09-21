#!/bin/bash

if [[ -f "$HOME/bin/subl-handler" ]]
then
	echo "$HOME/bin/subl-handler already exists, skipping copy."
	echo "If you need to overwrite it, do it manually."
else
	mkdir -p "$HOME/bin"
	cp "./subl-handler" "$HOME/bin/subl-handler"
fi

if [[ -f "$HOME/.local/share/applications/subl-handler.desktop" ]]
then
	echo "$HOME/.local/share/applications/subl-handler.desktop already exists."
	echo "If you need to overwrite it, do it manually."
else
	mkdir -p "$HOME/.local/share/applications/"
	cat > "$HOME/.local/share/applications/subl-handler.desktop" <<EOF
	[Desktop Entry]
	Name=subl-handler
	Comment=Sublime Text URI scheme subl:// handler
	Exec=$HOME/bin/subl-handler %u
	Terminal=0
	Type=Application
	X-MultipleArgs=True
	MimeType=x-scheme-handler/subl
	Encoding=UTF-8
	Categories=Application;
EOF

	update-desktop-database "$HOME/.local/share/applications/"
	xdg-mime default subl-handler.desktop x-scheme-handler/subl
fi
