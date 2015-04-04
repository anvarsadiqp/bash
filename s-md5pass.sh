#!/bin/bash
# ping me on github https://github.com/anvarsadiqp/bash
# to generate a md5 password in command line
# run : bash~# sh md5pass.sh pass
pas=$1
pass=$(md5pass $pas)
echo "MD5 Password of $pas - "$pass
