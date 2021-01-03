#!/bin/bash

set -eua

TMP=$(mktemp /tmp/scanned.XXXX)

INPUT_FILE="$1"
OUTPUT_FILE="$2"

convert -density 150 "$INPUT_FILE" -colorspace gray -linear-stretch \
	3.5%x10% -blur 0x0.5 -attenuate 0.25 +noise Gaussian  \
	-rotate 1.0 "$TMP" 
gs -dSAFER -dBATCH -dNOPAUSE -dNOCACHE -sDEVICE=pdfwrite \
	-sColorConversionStrategy=LeaveColorUnchanged \
	-dAutoFilterColorImages=true -dAutoFilterGrayImages=true \
	-dDownsampleMonoImages=true -dDownsampleGrayImages=true \
	-dDownsampleColorImages=true -sOutputFile="$OUTPUT_FILE" "$TMP"

rm "$TMP"
