#!/usr/bin/env bash
#  ██████╗  █████╗ ███╗   ██╗██╗███████╗██╗      █████╗     ██████╗ ██╗ ██████╗███████╗
#  ██╔══██╗██╔══██╗████╗  ██║██║██╔════╝██║     ██╔══██╗    ██╔══██╗██║██╔════╝██╔════╝
#  ██║  ██║███████║██╔██╗ ██║██║█████╗  ██║     ███████║    ██████╔╝██║██║     █████╗
#  ██║  ██║██╔══██║██║╚██╗██║██║██╔══╝  ██║     ██╔══██║    ██╔══██╗██║██║     ██╔══╝
#  ██████╔╝██║  ██║██║ ╚████║██║███████╗███████╗██║  ██║    ██║  ██║██║╚██████╗███████╗
#  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Set bspwm configuration for Emilia
set_bspwm_config() {
	bspc config border_width 0
	bspc config top_padding 47
	bspc config bottom_padding 2
	bspc config left_padding 2
	bspc config right_padding 2
	bspc config normal_border_color "#414868"
	bspc config active_border_color "#c0caf5"
	bspc config focused_border_color "#bb9af7"
	bspc config presel_feedback_color "#7aa2f7"
}

# Set alacritty colorscheme
set_alacritty_config() {
	cat >"$HOME"/.config/alacritty/rice-colors.toml <<EOF
# (Catppuccin Mocha) color scheme for Daniela Rice

# Default colors
[colors.primary]
background = "#181825"
foreground = "#CDD6F4"

# Cursor colors
[colors.cursor]
text = "#181825"
cursor = "#F5E0DC"

[colors.selection]
text = "#181825"
background = "#F5E0DC"

# Normal colors
[colors.normal]
black = "#45475A"
red = "#F38BA8"
green = "#A6E3A1"
yellow = "#F9E2AF"
blue = "#89B4FA"
magenta = "#F5C2E7"
cyan = "#94E2D5"
white = "#BAC2DE"

# Bright colors
[colors.bright]
black = "#585B70"
red = "#F38BA8"
green = "#A6E3A1"
yellow = "#F9E2AF"
blue = "#89B4FA"
magenta = "#F5C2E7"
cyan = "#94E2D5"
white = "#A6ADC8"
EOF
}

# Set kitty colorscheme
set_kitty_config() {
  cat >"$HOME"/.config/kitty/current-theme.conf <<EOF
## This file is autogenerated, do not edit it, instead edit the Theme.sh file inside the rice directory.
## (Catppuccin Mocha) color scheme for Daniela Rice


# The basic colors
foreground              #CDD6F4
background              #181825
selection_foreground    #181825
selection_background    #F5E0DC

# Cursor colors
cursor                  #F5E0DC
cursor_text_color       #181825

# URL underline color when hovering with mouse
url_color               #89B4FA

# Kitty window border colors
active_border_color     #F5C2E7
inactive_border_color   #585B70
bell_border_color       #F9E2AF

# Tab bar colors
active_tab_foreground   #181825
active_tab_background   #F5C2E7
inactive_tab_foreground #BAC2DE
inactive_tab_background #45475A
tab_bar_background      #181825

# The 16 terminal colors

# black
color0 #45475A
color8 #585B70

# red
color1 #F38BA8
color9 #F38BA8

# green
color2  #A6E3A1
color10 #A6E3A1

# yellow
color3  #F9E2AF
color11 #F9E2AF

# blue
color4  #89B4FA
color12 #89B4FA

# magenta
color5  #F5C2E7
color13 #F5C2E7

# cyan
color6  #94E2D5
color14 #94E2D5

# white
color7  #BAC2DE
color15 #A6ADC8
EOF

killall -USR1 kitty
}

# Set compositor configuration
set_picom_config() {
	sed -i "$HOME"/.config/bspwm/picom.conf \
		-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
		-e "s/shadow-color = .*/shadow-color = \"#181825\"/g" \
		-e "s/corner-radius = .*/corner-radius = 6/g" \
		-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
		-e "s/\".*:class_g = 'kitty'\"/\"100:class_g = 'kitty'\"/g" \
		-e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g"
}

# Set dunst notification daemon config
set_dunst_config() {
	sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 0/g" \
		-e "s/frame_color = .*/frame_color = \"#181825\"/g" \
		-e "s/separator_color = .*/separator_color = \"#CDD6F4\"/g" \
		-e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
		-e "s/foreground='.*'/foreground='#F5C2E7'/g"

	sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
	cat >>"$HOME"/.config/bspwm/dunstrc <<-_EOF_
		[urgency_low]
		timeout = 3
		background = "#181825"
		foreground = "#CDD6F4"

		[urgency_normal]
		timeout = 6
		background = "#181825"
		foreground = "#CDD6F4"

		[urgency_critical]
		timeout = 0
		background = "#181825"
		foreground = "#CDD6F4"
	_EOF_
}

# Set eww colors
set_eww_colors() {
	cat >"$HOME"/.config/bspwm/eww/colors.scss <<EOF
// Eww colors for Daniela rice
\$bg: #181825;
\$bg-alt: #1e1e2e;
\$fg: #CDD6F4;
\$black: #45475A;
\$lightblack: #262831;
\$red: #F38BA8;
\$blue: #89B4FA;
\$cyan: #94E2D5;
\$magenta: #F5C2E7;
\$green: #A6E3A1;
\$yellow: #F9E2AF;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Daniela
set_jgmenu_colors() {
	sed -i "$HOME"/.config/bspwm/jgmenurc \
		-e 's/color_menu_bg = .*/color_menu_bg = #181825/' \
		-e 's/color_norm_fg = .*/color_norm_fg = #CDD6F4/' \
		-e 's/color_sel_bg = .*/color_sel_bg = #1e1e2e/' \
		-e 's/color_sel_fg = .*/color_sel_fg = #CDD6F4/' \
		-e 's/color_sep_fg = .*/color_sep_fg = #45475A/'
}

# Set rofi colors
set_launcher_config() {
	cat >"$HOME"/.config/bspwm/src/rofi-themes/shared.rasi <<EOF
// Rofi colors for Daniela

* {
    font: "JetBrainsMono NF Bold 9";
    background: #181825;
    background-alt: #181825E0;
    foreground: #CDD6F4;
    selected: #F5C2E7;
    active: #A6E3A1;
    urgent: #F38BA8;
    
    img-background: url("~/.config/bspwm/rices/daniela/rofi.webp", width);
}
EOF
}

# Launch the bar
launch_bars() {

	for mon in $(polybar --list-monitors | cut -d":" -f1); do
		MONITOR=$mon polybar -q dani -c "${rice_dir}"/config.ini &
	done

}

### ---------- Apply Configurations ---------- ###

set_bspwm_config
set_alacritty_config
set_kitty_config
set_picom_config
launch_bars
set_eww_colors
set_jgmenu_colors
set_dunst_config
set_launcher_config
