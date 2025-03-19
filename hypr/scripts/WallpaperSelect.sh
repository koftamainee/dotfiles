#!/bin/bash

SCRIPTSDIR="$HOME/.config/hypr/scripts"

# WALLPAPERS PATH
wallDIR="$HOME/Pictures/wallpapers"

# Transition config
FPS=30
TYPE="wipe"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"



# Retrieve image files
PICS=($(ls "${wallDIR}" | grep -E ".jpg$|.jpeg$|.png$|.gif$"))
RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
RANDOM_PIC_NAME="${#PICS[@]}. random"

# Rofi command
rofi_command="rofi -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi"

menu() {
  for i in "${!PICS[@]}"; do
    # Displaying .gif to indicate animated images
    if [[ -z $(echo "${PICS[$i]}" | grep .gif$) ]]; then
      printf "$(echo "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${wallDIR}/${PICS[$i]}\n"
    else
      printf "${PICS[$i]}\n"
    fi
  done

  printf "$RANDOM_PIC_NAME\n"
}


main() {
  choice=$(menu | ${rofi_command})

  # No choice case
  if [[ -z $choice ]]; then
    exit 0
  fi

  swww-daemon

  # Random choice case
  if [ "$choice" = "$RANDOM_PIC_NAME" ]; then
    swww img "${wallDIR}/${RANDOM_PIC}" $SWWW_PARAMS
    exit 0
  fi

  # Find the index of the selected file
  pic_index=-1
  for i in "${!PICS[@]}"; do
    filename=$(basename "${PICS[$i]}")
    if [[ "$filename" == "$choice"* ]]; then
      pic_index=$i
      break
    fi
  done

  if [[ $pic_index -ne -1 ]]; then
    swww img "${wallDIR}/${PICS[$pic_index]}" $SWWW_PARAMS
  else
    echo "Image not found."
    exit 1
  fi
}

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
  exit 0
fi

main

wait $!
"$SCRIPTSDIR/Wallust.sh" &&

wait $!
sleep 2
"$SCRIPTSDIR/Refresh.sh"

sleep 0.5
${SCRIPTSDIR}/PywalSwww.sh
sleep 0.2
${SCRIPTSDIR}/Refresh.sh

SCRIPTSDIR="$HOME/.config/hypr/scripts"

# Файл состояния для хранения последнего установленного обоя
LAST_WALLPAPER_FILE="$HOME/.config/hypr/last_wallpaper"

# WALLPAPERS PATH
wallDIR="$HOME/Pictures/wallpapers"

# Transition config
FPS=30
TYPE="wipe"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Retrieve image files (включая mp4)
PICS=($(ls "${wallDIR}" | grep -E "\.jpg$|\.jpeg$|\.png$|\.mp4$"))

# Rofi command
rofi_command="rofi -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi"

menu() {
  for i in "${!PICS[@]}"; do
    # Если файл не .gif, выводим с иконкой
    if [[ -z $(echo "${PICS[$i]}" | grep "\.gif$") ]]; then
      printf "$(echo "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${wallDIR}/${PICS[$i]}\n"
    else
      printf "${PICS[$i]}\n"
    fi
  done
}

main() {
  choice=$(menu | ${rofi_command})

  # Если ничего не выбрано
  if [[ -z $choice ]]; then
    exit 0
  fi

  swww-daemon

  # Поиск выбранного файла
  pic_index=-1
  for i in "${!PICS[@]}"; do
    filename=$(basename "${PICS[$i]}")
    if [[ "$filename" == "$choice"* ]]; then
      pic_index=$i
      break
    fi
  done

  if [[ $pic_index -ne -1 ]]; then
    SELECTED_FILE="${wallDIR}/${PICS[$pic_index]}"
    ext="${PICS[$pic_index]##*.}"
    if [[ "$ext" == "mp4" ]]; then
      IS_VIDEO=1
      TMP_FRAME="${wallDIR}/.$(basename "${SELECTED_FILE%.*}")_frame.jpg"
      ffmpeg -y -i "$SELECTED_FILE" -vf "select=eq(n\,0)" -q:v 3 "$TMP_FRAME"
      swww img "$TMP_FRAME" $SWWW_PARAMS
    else
      IS_VIDEO=0
      swww img "$SELECTED_FILE" $SWWW_PARAMS
    fi
  else
    echo "Файл не найден."
    exit 1
  fi

  # Запись информации о последнем установленном обое
  if [[ "$IS_VIDEO" -eq 1 ]]; then
    echo "type=video" > "$LAST_WALLPAPER_FILE"
    echo "path=$SELECTED_FILE" >> "$LAST_WALLPAPER_FILE"
  else
    echo "type=image" > "$LAST_WALLPAPER_FILE"
    echo "path=$SELECTED_FILE" >> "$LAST_WALLPAPER_FILE"
  fi
}

# Если rofi уже запущен — завершаем его
if pidof rofi > /dev/null; then
  pkill rofi
  exit 0
fi

main

wait $!
"$SCRIPTSDIR/Wallust.sh" &&

wait $!
sleep 2
"$SCRIPTSDIR/Refresh.sh"

# Если выбран видеофайл, завершаем swww и запускаем mpvpaper для видео
if [[ "$IS_VIDEO" -eq 1 ]]; then
  swww kill
  mpvpaper -vs -o "no-audio loop --panscan=1.0" eDP-1 "$SELECTED_FILE"
fi
