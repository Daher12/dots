#!/bin/bash
 
lock=" Lock"
logout="󰍂 Logout"
shutdown="⏻ Poweroff"
reboot="󰑓 Reboot"
sleep=" Suspend"
 
selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu -i -p "Powermenu" \
		  -theme "~/.config/rofi/powermenu.rasi")

if [ "$selected_option" == "$lock" ]
then
  gtklock -d
elif [ "$selected_option" == "$logout" ]
then
  loginctl kill-user dk
elif [ "$selected_option" == "$shutdown" ]
then
  sh /home/dk/.local/shutdown.sh
elif [ "$selected_option" == "$reboot" ]
then
  sh /home/dk/.local/reboot.sh
elif [ "$selected_option" == "$sleep" ]
then
   loginctl suspend
else
  echo "No match"
fi
