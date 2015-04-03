#!/bin/bash
pas=$1
pass=$(md5pass $pas)
echo "MD5 Password of $pas - "$pass
