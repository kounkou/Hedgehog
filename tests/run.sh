#!/bin/sh

function replaceDestinationBinary() {
    file='Makefile'
    string_to_replace='tests.app\/Contents\/MacOS\/'
    replacement_string=''

    # Use sed to replace the string
    sed -i '' "s/$string_to_replace/$replacement_string/g" "$file"

    echo "Replaced '$string_to_replace' with '$replacement_string' in '$file'."
}

make clean
qmake
replaceDestinationBinary
make
./tests