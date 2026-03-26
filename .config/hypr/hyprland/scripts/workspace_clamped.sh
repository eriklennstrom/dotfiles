#!/usr/bin/env bash
# Workspace dispatcher that clamps to groups of N (default 7)
# Usage: workspace_clamped.sh <dispatcher> <direction>
# direction: +1, -1, r+1, r-1, etc.

GROUP_SIZE=7
curr_workspace="$(hyprctl activeworkspace -j | jq -r ".id")"
dispatcher="$1"
direction="$2"

if [[ -z "${dispatcher}" || -z "${direction}" ]]; then
  echo "Usage: $0 <dispatcher> <direction>"
  exit 1
fi

group_start=$(( ((curr_workspace - 1) / GROUP_SIZE) * GROUP_SIZE + 1 ))
group_end=$(( group_start + GROUP_SIZE - 1 ))

# Calculate target based on direction
case "${direction}" in
  +1|r+1)  target=$((curr_workspace + 1)) ;;
  -1|r-1)  target=$((curr_workspace - 1)) ;;
  +5|r+5)  target=$((curr_workspace + 5)) ;;
  -5|r-5)  target=$((curr_workspace - 5)) ;;
  m+1)     hyprctl dispatch "${dispatcher}" "m+1"; exit 0 ;;
  m-1)     hyprctl dispatch "${dispatcher}" "m-1"; exit 0 ;;
  *)       hyprctl dispatch "${dispatcher}" "${direction}"; exit 0 ;;
esac

# Clamp to group boundaries
if (( target < group_start )); then
  target=$group_start
fi
if (( target > group_end )); then
  target=$group_end
fi

hyprctl dispatch "${dispatcher}" "${target}"
