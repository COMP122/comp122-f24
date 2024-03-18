#! /bin/bash

function base2_digits () {
  local digits=0
  local hex_digits=0

  [[ $# == 1 ]] || { digits="$1" ; hex_digits="$(( digits >> 2))"; shift; }
  local value="$1"

  local hex=$(printf "%0${hex_digits}x" $(( $value )) )

  local bin=
  if (( $value >= 0 )) ; then
    bin=0000
  else
    bin=1111
  fi

  for (( i = 0 ; i < ${#hex} ; i++ )) ; do
    case ${hex:$i:1} in 
        0)   bin="${bin}0000" ;;
        1)   bin="${bin}0001" ;;
        2)   bin="${bin}0010" ;;
        3)   bin="${bin}0011" ;;
        4)   bin="${bin}0100" ;;
        5)   bin="${bin}0101" ;;
        6)   bin="${bin}0110" ;;
        7)   bin="${bin}0111" ;;
        8)   bin="${bin}1000" ;;
        9)   bin="${bin}1001" ;;
        a|A) bin="${bin}1010" ;;
        b|B) bin="${bin}1011" ;;
        c|C) bin="${bin}1100" ;;
        d|D) bin="${bin}1101" ;;
        e|E) bin="${bin}1110" ;;
        f|F) bin="${bin}1111" ;;
    esac
  done
  if (( $digits == 0 )) ; then   #get ride of the extra padding up front
    bin=${bin:4}
  fi

  # If digits < size of bin, then we need to truncate the number
  if (( $digits < ${#bin} )) ; then 
    echo ${bin: -$digits}
  else
    echo ${bin}
  fi
}

function base2 () {
  for i in "$@" ; do 
    local bin="$(base2_digits $i)"
    printf "0b%s " $bin
  done
  printf "\n"
}

function base8_digits () {
  local digits=0

  [[ $# == 1 ]] || { digits="$1"; shift; }
  local value="$1"

  printf "%0${digits}o" $(( $value ))
}
function base8 () {

  for i in $@ ; do 
    # special case of just 0 --> 00
    printf "0%s " "$(base8_digits $i )"
  done
  printf "\n"
}

function base10_digits () {
  local digits=0

  [[ $# == 1 ]] || { digits="$1"; shift; }
  local value="$1"
  
  printf "% ${digits}d" $(( $value ))
}
function base10 () {

  for i in $@ ; do 
        printf "%s " "$(base10_digits $i )"
  done
  printf "\n"
}

function base16_digits () {
  local value="$1"
  local digits=0

  [[ $# == 1 ]] || { digits="$1"; shift; }
  local value="$1"

  printf "%0${digits}x" $(( $value ))
}
function base16 () {

  for i in $@ ; do 
        printf "0x%s " "$(base16_digits $i )"
  done
  printf "\n"
}

function ascii.index () {
  str="$*"
  for (( i = 0; i < ${#str}; i++ )) ; do 
    local glyph=${str:i:1}
    if [[ ${glyph} == '\' ]] ; then 
      local next=${str:i+1:1}
      ((i ++))
      case $next in 
         0 ) value="0" ;;
         a ) value="7" ;;
         b ) value="8" ;;
         t ) value="9" ;;
         n ) value="10" ;;
         v ) value="11" ;;
         f ) value="12" ;;
         r ) value="13" ;;
         e ) value="27" ;;
         '\' ) value="92" ;;
         * ) value=0xFF ; echo "$next" ;;  # an error
      esac
      printf "%d " "$value"
    else
      printf "%d " "'${glyph}"
    fi
  done
  printf "\n"
}

function ascii.char () {
  for i in $@   ; do 
    if ((  0x20 <= $i && $i <= 0x7e )) ; then 
      printf \\$(printf '%03o' $(( $i )) )
    else
      char=""
      case $i in 
          0) char="\\0" ;;
          7) char="\\a" ;;
          8) char="\\b" ;;
          9) char="\\t" ;;
         10) char="\\n" ;;
         11) char="\\v" ;;
         12) char="\\f" ;;
         13) char="\\r" ;;
         27) char="\\e" ;;
      esac
      echo -n "$char"
    fi
  done
  printf "\n"
}




