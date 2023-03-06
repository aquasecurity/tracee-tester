#!/bin/sh

exit_err() {
    echo -n "ERROR: "
    echo $@
    exit 1
}

uname -a | grep -q aarch64 && arch=aarch64
uname -a | grep -q x86_64 && arch=x86_64

cd /$arch

what=$@

for test in $@; do
    t=$test

    t=${t#"TRC-"}
    t=${t#"trc-"}
    t=${t#"TRC"}
    t=${t#"trc"}
    t=${t%".sh"}

    file=trc${t}.sh

    if [ ! -x $file ]; then
        exit_err "could not find test $file"
    fi

    ./$file
done

