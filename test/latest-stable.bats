#!/usr/bin/env bats

setup() {
    ASDF_GODOT="$(dirname "$BATS_TEST_DIRNAME")"
    # If we put this in $BATS_RUN_TMPDIR, no teardown is required since it's
    # handled by bats.
    ASDF_TMPDIR="$(TMPDIR="${BATS_RUN_TMPDIR}" mktemp -t "test-${BATS_SUITE_TEST_NUMBER}.XXXXXXXXX" -d)"
    ASDF_DATA_DIR="$(bats_readlinkf "${ASDF_TMPDIR}")"
    export ASDF_DATA_DIR
    asdf plugin-add godot "${ASDF_GODOT}"
    asdf plugin-add redot "${ASDF_GODOT}"
}

@test "latest stable godot" {
    run asdf list-all godot
    [ "$status" -eq 0 ]
    # match format <version i.e 4.3 or 4.2.2>-<type of release i.e stable, dev>
    [[ "$output" =~ [0-9]\.[0-9](\.[0-9])?\-[a-zA-Z]+ ]]
}

@test "latest stable redot" {
    run asdf list-all redot
    [ "$status" -eq 0 ]
    # match format <godot or redot>-<version i.e 4.3 or 4.2.2>-<type of release i.e stable, dev>
    [[ "$output" =~ (godot|redot)+\-[0-9]\.[0-9](\.[0-9])?\-[a-zA-Z]+ ]]
}


