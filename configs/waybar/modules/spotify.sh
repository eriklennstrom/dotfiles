#!/usr/bin/env bash
class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
pause=""
play=""
info=$(playerctl metadata --player=spotify --format '  {{title}} - {{artist}}')

if [[ $class == "playing" ]]; then
  if [[ ${#info} > 40 ]]; then
    info=$(echo $info | cut -c1-40)"..."
  fi
  text="$play $info"
elif [[ $class == "paused" ]]; then
  text="$pause $info"
elif [[ $class == "stopped" ]]; then
  text=""
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"

