#!/bin/bash

# COLOR CODES -> https://www.tweaking4all.com/software/linux-software/xterm-color-cheat-sheet/

# 16 Basic Colors
# BASIC_COLOR_BLACK=000
# BASIC_COLOR_RED=009
# BASIC_COLOR_GREE=010
# BASIC_COLOR_YELLOW=011
# BASIC_COLOR_BLU=012
# BASIC_COLOR_PINK=013
# BASIC_COLOR_CYAN=014
# BASIC_COLOR_WHITE=015

# 256 Color Support
# ALL_COLOR_BLACK=016
# ALL_COLOR_RED=160
# ALL_COLOR_GREE=040
# ALL_COLOR_YELLOW=226
# ALL_COLOR_BLU=027
# ALL_COLOR_PINK=161
# ALL_COLOR_CYAN=051
# ALL_COLOR_WHITE=231


function checkColorSupport() {
  # Terminal can return => 16, 24, 256
  # Docker Version Alpine does NOT have `tput` and all versions will be 'basic'
  if [ "$(tput colors)" -ge 256 ]; then
    echo 'all'
  else
    echo 'basic'
  fi
}

function customLogger() {
  local color=$1
  local message=$2
  printf "\e[38;5;${color}m${message}\e[0m\n"
}


function logText() {
    local message=$1
    local color
    color=$([ "$(checkColorSupport)" = 'all' ] && echo "231" || echo "015")
    customLogger "$color" "$message"
}

function logInfo() {
    local message=$1
    local color
    color=$([ "$(checkColorSupport)" = 'all' ] && echo "051" || echo "014") # CYAN / BLUE
    customLogger "$color" "$message"
}

function logCallout() {
    local message=$1
    local color
    color=$([ "$(checkColorSupport)" = 'all' ] && echo "161" || echo "013") # PINK / MAGENTA
    customLogger "$color" "$message"
}

function logWarning() {
    local message=$1
    local color
    color=$([ "$(checkColorSupport)" = 'all' ] && echo "226" || echo "011") # YELLOW / ORANGE
    customLogger "$color" "$message"
}

function logError() {
    local message=$1
    local color
    color=$([ "$(checkColorSupport)" = 'all' ] && echo "160" || echo "009") # RED
    customLogger "$color" "$message"
}

function logSuccess() {
    local message=$1
    local color
    color=$([ "$(checkColorSupport)" = 'all' ] && echo "040" || echo "010") # GREEN
    customLogger "$color" "$message"
}


function logTest() {
   logText "Testing... this is my custom logger"
   logInfo "\n${SHELL}"
   logCallout "\n** Notice - This is the 'callout' function **"
   logWarning "\n== Warning ==\n- You can format and add more text"
   logSuccess "\n== Success ==\n- Your command was successful"
}
