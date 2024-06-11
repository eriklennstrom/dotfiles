#!/usr/bin/env bash

engine=""

which "docker" > /dev/null 2>&1
if [[ $? -eq 0 ]] 
then
  engine="docker"
fi
  
RUNNING_CONTAINERS=$($engine ps --format "{{.ID}} | {{.Names}} | {{.Image}} | {{.Ports}} | {{.Status}}")
RUNNING_CONTAINERS_STR=$(printf "%s" "$RUNNING_CONTAINERS" | sed ':a;N;$!ba;s/\n/\\n/g; s/"/\\"/g')
NUMBER_RUNNING_CONTAINERS=$(printf "%s\n" "$RUNNING_CONTAINERS" | wc -l)
NUMBER_TOTAL_CONTAINERS=$($engine ps -qa | wc -l)

printf "{\"text\": \"  <span color='#aaaaaa'>%s</span> [<span color='#aaaaaa'>%s</span>]\", \"tooltip\": \"$RUNNING_CONTAINERS_STR\", \"alt\": \"\", \"class\": \"\" }" \
  "$NUMBER_RUNNING_CONTAINERS" "$NUMBER_TOTAL_CONTAINERS"
