#!/usr/bin/env bats

setup() {
    ASDF_GODOT="$(dirname "$BATS_TEST_DIRNAME")"
    # If we put this in $BATS_RUN_TMPDIR, no teardown is required since it's
    # handled by bats.
    ASDF_TMPDIR="$(TMPDIR="${BATS_RUN_TMPDIR}" mktemp -t "test-${BATS_SUITE_TEST_NUMBER}.XXXXXXXXX" -d)"
    ASDF_DATA_DIR="$(bats_readlinkf "${ASDF_TMPDIR}")"
    export ASDF_DATA_DIR
    asdf plugin add godot "${ASDF_GODOT}"
    asdf plugin add redot "${ASDF_GODOT}"
}

@test "can install godot 4.3" {
    run asdf install godot 4.3-stable
    [ "$status" -eq 0 ]
    [[ "$output" != *"fail: command not found"* ]] # mac os doesn't have fail installed
    [[ "$output" == *"godot 4.3-stable installation was successful!"* ]]
}

@test "can install godot mono 4.3" {
    ASDF_GODOT_INSTALL_MONO=1 run asdf install godot 4.3-stable
    [ "$status" -eq 0 ]
    [[ "$output" != *"fail: command not found"* ]] # mac os doesn't have fail installed
    [[ "$output" == *"godot 4.3-stable installation was successful!"* ]]
}


@test "can install godot latest" {
    # fails now but should look into once i have other parts done
    run asdf install godot latest-stable
    [ "$status" -eq 1 ]
}

@test "godot command fails on invalid version" {
    run asdf install godot ref
    [ "$status" -eq 1 ]
}

@test "can install redot 4.3" {
    run asdf install redot redot-4.3-stable
    [ "$status" -eq 0 ]
    [[ "$output" != *"fail: command not found"* ]] # mac os doesn't have fail installed
    [[ "$output" == *"redot redot-4.3-stable installation was successful!"* ]]
}

@test "can install redot mono 4.3" {
    ASDF_GODOT_INSTALL_MONO=1 run asdf install redot redot-4.3-stable
    [ "$status" -eq 0 ]
    [[ "$output" != *"fail: command not found"* ]] # mac os doesn't have fail installed
    [[ "$output" == *"redot redot-4.3-stable installation was successful!"* ]]
}


@test "can install redot latest" {
    # fails now but should look into once i have other parts done
    run asdf install godot latest-stable
    [ "$status" -eq 1 ]
}

@test "redot command fails on invalid version" {
    run asdf install redot ref
    [ "$status" -eq 1 ]
}
