#!/bin/bash

# Some useful bash functions


#df | grep sda #tr -s ' ' | cut -d ' ' -f 5  |sed -e '1d'| sed 's/[^0-9]*//g'

# Cut column whitespace delimited
# $1 is data
# $2 is column(s) to keep
fields_whitespace_delim() { 
  echo "$1" | tr -s ' ' | cut -d ' ' -f $2
}

drop_first_line() {
  echo "$1" | sed -e '1d'
}

remove_non_numeric() {
  echo "$1" | sed 's/[^0-9]*//g'
}

df_sda() {
  dfline=`df -h | grep sda1`
  df1=$(fields_whitespace_delim "$dfline" 5)
  diskused=$(remove_non_numeric "$df1")
  declare -i df
  df=100-diskused
  echo "$df"
}

ram_free() {
  freeline=`free -m | grep buffers/cache`
  declare -i free
  free=$(fields_whitespace_delim "$freeline" 4)
  echo "$free"
}



