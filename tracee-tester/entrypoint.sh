#!/bin/sh

exit_err() {
    echo -n "ERROR: "
    echo $@
    exit 1
}


what=$@

for test in $@; do
    t=$test

    t=${t#"TRC-"}
    t=${t#"trc-"}
    t=${t#"TRC"}
    t=${t#"trc"}
    t=${t%".sh"}

    file=./trc${t}.sh

    if [ ! -x $file ]; then
        exit_err "could not find test $file"
    fi

    ./$file

done

