#!/bin/bash
#set -x
# Ejecting drive seamlessly
UDISKS="/usr/bin/udisksctl"
# Define help function
function print_help () {
  echo "switch: [-h|-?|--h|--help] [-i|--interactive]"
  echo "usage: ejecting [drive name]"
  echo -e "       ejecting /dev/sdb"
  echo
  echo "Toggle --interactive switch to automate task"
}

function package_check () {
  command -v udisksctl >/dev/null 2>&1 || { echo >&2 \
        "udisks2 package required but it is not installed.  Aborting. \
        You can install it by typing sudo apt-get install udisks2"; }
}

function interactive () {
  declare -a drive
  # Print current drive on which Ubuntu/Linux is installed on
  local current_drive=$(findmnt -n -o SOURCE --target / | tr -d 0-9) # Most common is /dev/sda, but the command should pick any other regardless of its name
  package_check

  # Print all drive excluding the one Ubuntu is installed to, store them on array
  oldIFS=$IFS; IFS=$'\n' drive=( $(mount | grep "/dev/sd*[a-z][0-9]" | grep -v "$current_drive" | sed 's/type.*//') ); IFS=$oldIFS
  if [ ${#drive[@]} -eq 0 ]; then
    echo "External drive not detected !"
  else
    echo "============================================="
    echo "Please select your drive name to be ejected"
    echo "============================================="
    echo "Your current drive is $current_drive"
    echo "============================================="
    select drives in "${drive[@]}" "Cancel"
    do
      [[ $drives = Cancel ]] && echo "Bye !" && break
      local DRIVE_PARTITION=$(echo $drives | sed 's/on.*//' | sed 's/ //g')
      local DRIVE_NAME=$(tr -d 0-9 <<<$DRIVE_PARTITION)
      echo "Ejecting $DRIVE_PARTITION from system"
      $UDISKS unmount -b "$DRIVE_PARTITION" >/dev/null
      $UDISKS power-off -b "$DRIVE_NAME"
      echo "Done !" && break
    done
  fi
}

while :; do
  case $1 in
    -h|-\?|--h|--help )
    print_help
    exit 0
    ;;
    -i|--interactive )
    interactive
    exit 0
    ;;
    *)
    break
  esac
done

if [ $# -gt 0 ]; then
  DRIVE_NAME="$1"
  current_drive=$(findmnt -n -o SOURCE --target / | tr -d 0-9)
  if [ ! -b "$DRIVE_NAME" ]; then
    echo "Drive doesn't exist"
    exit 2
  fi
  if [ "$1" == "$current_drive" ]; then
    echo "You can't unmount currently used partition (main system)"
    exit 2
  fi
  declare -a drive
  OLDIFS=$IFS
  IFS=$'\n' read -d '' -r -a drive < <(lsblk -f $DRIVE_NAME | awk -vT="/dev/" 'NR>2 { print T$1 }' | tr -dc '/[:alnum:]\n\r')
  IFS=${OLDIFS}

  for partition in "${drive[@]}"; do
    { $UDISKS unmount -b $partition >/dev/null ; } && echo "Unmounting $partition"
  done
  $UDISKS power-off -b $DRIVE_NAME && echo "Powering off $DRIVE_NAME"
else
  echo "Missing option !!"
  echo "Execute ejecting --help to display usage"
  exit 1
fi
