#!/usr/bin/bash

printf "\E[6n";read -sdR CURPOS; CURPOS=${CURPOS#*[}; C="${CURPOS#*;}"

[ "$C" -ne 1 ] && echo
